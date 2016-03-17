//
//  TimeTableData.swift
//  Time Table
//
//  Created by Nash Vail on 08/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import Foundation

// Data for time table 

struct TimeTable {
	let days:[Day]
}

// Since we can't make a DaySection as key for the Dictionary we will use two arrays and have
// values for a DaySection at the same corresponding subjet index

struct Day {
	let dayName:String
	let timeTable:[DaySection:Subject]
}

struct Subject {
	let name:String
}

struct DaySection:Hashable {
	let startTime:Time
	let endTime:Time
	
	var hashValue: Int {
		return startTime.hours + endTime.hours + startTime.minutes + endTime.minutes
	}
	
	func toString() -> String {
		return "\(startTime.toString()) - \(endTime.toString())"
	}
}

// Making the DaySection struct Equatable
@warn_unused_result func ==(lhs: DaySection, rhs: DaySection) -> Bool {
	return (lhs.startTime == rhs.startTime && lhs.endTime == rhs.endTime)
}

struct Time {
	let hours:Int
	let minutes: Int
	
	func militaryRepresentation() -> Int {
		return (hours * 100) + minutes
	}
	
	func toString() -> String {
		
		// If minutes is 0 the follwing line will convert to 00
		let formattedMinutes = String(format: "%.2d", minutes)
		
		if hours > 12 {
			return "\(hours - 12):\(formattedMinutes) PM"
		} else if hours == 12 {
				return "\(hours):\(formattedMinutes) PM"
		} else {
			return "\(hours):\(formattedMinutes) AM"
		}
	}
}

// Making the Time struct equatable
@warn_unused_result func ==(lhs: Time, rhs: Time) -> Bool {
	return (lhs.hours == rhs.hours && lhs.minutes == rhs.minutes)
}

// Data for the sections of the day
let daySection_one = DaySection(startTime: Time(hours: 8, minutes: 30), endTime: Time(hours: 9, minutes: 25))
let daySection_two = DaySection(startTime: Time(hours: 9, minutes: 25), endTime: Time(hours: 10, minutes: 20))
let daySection_three = DaySection(startTime: Time(hours: 10, minutes: 30), endTime: Time(hours: 11, minutes: 25))
let daySection_four = DaySection(startTime: Time(hours: 11, minutes: 25), endTime: Time(hours: 12, minutes: 20))

let daySection_five = DaySection(startTime: Time(hours: 14, minutes: 00), endTime: Time(hours: 14, minutes: 55))
let daySection_six = DaySection(startTime: Time(hours: 14, minutes: 55), endTime: Time(hours: 15, minutes: 50))
let daySection_seven = DaySection(startTime: Time(hours: 15, minutes: 50), endTime: Time(hours: 16, minutes: 45))
let daySection_eight = DaySection(startTime: Time(hours: 16, minutes: 45), endTime: Time(hours: 17, minutes: 40))


// Data for subjects
let subject_tcs = Subject(name: "Theoretical Computer Science")
let subject_communicationSys = Subject(name: "Communication Systems")
let subject_controlSys = Subject(name: "Control Systems")
let subject_mathematics = Subject(name: "Engineering Mathematics")
let subject_dbms = Subject(name: "DBMS")
let subject_softwareTools = Subject(name: "Software Tools")
let subject_lab_communicationSys = Subject(name: "Lab Comm. Systems")
let subject_lab_controlSys = Subject(name: "Lab Cont. Systems")
let subject_lab_dbms = Subject(name: "Lab DBMS")

// Data for Days of the week

// TODO: fix for when the day sections are not consecutive and the app cakes its pants

let Monday = Day(dayName: "Monday",
	timeTable: [
		daySection_one: subject_tcs,
		daySection_two: subject_tcs,
		daySection_three: subject_mathematics,
		daySection_four: subject_communicationSys,
		daySection_five: subject_lab_communicationSys,
		daySection_six: subject_lab_communicationSys,
		daySection_seven: subject_lab_dbms,
		daySection_eight: subject_lab_dbms,
	])

let Tuesday = Day(dayName: "Tuesday",
	timeTable: [
		daySection_one: subject_controlSys,
		daySection_two: subject_communicationSys,
		daySection_three: subject_dbms,
		daySection_four: subject_dbms
	])

let Wednesday = Day(dayName: "Wednesday",
	timeTable: [
		daySection_one: subject_tcs,
		daySection_two: subject_mathematics,
		daySection_three: subject_communicationSys,
		daySection_four: subject_softwareTools,
	])

let Thursday = Day(dayName: "Thursday",
	timeTable: [
		daySection_one: subject_dbms,
		daySection_two: subject_communicationSys,
		daySection_three: subject_controlSys,
		daySection_four: subject_mathematics,
		daySection_five: subject_lab_controlSys,
		daySection_six: subject_lab_controlSys,
	])

let Friday = Day(dayName: "Friday",
	timeTable: [
		daySection_one: subject_softwareTools,
		daySection_two: subject_softwareTools,
		daySection_three: subject_tcs,
		daySection_four: subject_dbms,
		daySection_five: subject_mathematics,
		daySection_six: subject_controlSys
	])

// Full time table data
let timeTable = TimeTable(days: [Monday, Tuesday, Wednesday, Thursday, Friday])

let Days:[String:Int] = [
	"Monday" : 0,
	"Tuesday" : 1,
	"Wednesday" : 2,
	"Thursday" : 3,
	"Friday" : 4,
]

let daySections = [daySection_one, daySection_two, daySection_three, daySection_four, daySection_five, daySection_six, daySection_seven, daySection_eight]
