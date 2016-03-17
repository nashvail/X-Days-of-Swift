//
//  TimeTableViewController.swift
//  Time Table
//
//  Created by Nash Vail on 06/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

class TimeTableViewController: UITableViewController {
	
	var currentDay = "Monday"
	var todaysTimeTable = [DaySection:Subject]()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false

		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem()
		
		let font_Avenir = UIFont(name: "Avenir Next", size: 20)
		let font_AvenirBold = UIFont(descriptor: font_Avenir!.fontDescriptor().fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold), size: CGFloat(20))
		
		self.view.backgroundColor = defaultColor
		self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
		self.tableView.tableFooterView = UIView(frame: CGRectZero)
		self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: font_AvenirBold]
		self.navigationController?.navigationBar.titleTextAttributes
		
	}
	

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Table view data source

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
			// #warning Incomplete implementation, return the number of sections
			return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			// #warning Incomplete implementation, return the number of rows
		return timeTable.days[Days[currentDay]!].timeTable.count
	}


	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("timeTableCell", forIndexPath: indexPath) as! TimeTableViewCell
		
		let todaysTimeTable = timeTable.days[Days[currentDay]!].timeTable
		let daySectionForRow = daySections[indexPath.row]
		let subjectForRow = todaysTimeTable[daySectionForRow]
		cell.label_time.text = "\(daySectionForRow.toString())"
		cell.label_subjectName.text = subjectForRow?.name
		
		return cell
	}
	
	override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
		if isActiveDaySection(daySections[indexPath.row]) {
			cell.backgroundColor = currentSubjectColor
		} else {
  		cell.backgroundColor = colorForCellAtIndex(index: indexPath.row)
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		currentDay = todaysDayName()
		self.title = currentDay
		reloadDataAndAnimate()
	}
	

	/*
	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
			// Return false if you do not want the specified item to be editable.
			return true
	}
	*/

	/*
	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
			if editingStyle == .Delete {
					// Delete the row from the data source
					tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
			} else if editingStyle == .Insert {
					// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
			}    
	}
	*/

	/*
	// Override to support rearranging the table view.
	override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

	}
	*/

	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
			// Return false if you do not want the item to be re-orderable.
			return true
	}
	*/

	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
			// Get the new view controller using segue.destinationViewController.
			// Pass the selected object to the new view controller.
	}
	*/
	
	
	// MARK: Cell coloring functions
	
	func colorForCellAtIndex(index index:Int) -> UIColor {
		return colorWithHexString(cellColors[index])
	}
	
	// MARK: Navigation Functions
	
	// This is called when we go to the Menu view to the Time table view
	@IBAction func unwindToHome(segue: UIStoryboardSegue) {
		let sourceController = segue.sourceViewController as! MenuTableViewController
		
		var dayToDisplay = sourceController.currentItem
		
		if dayToDisplay == "Today" {
			dayToDisplay = todaysDayName()
		}
		
		self.title = dayToDisplay
		currentDay = dayToDisplay
		reloadDataAndAnimate()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let menuTableViewController = segue.destinationViewController as! MenuTableViewController
		menuTableViewController.currentItem = self.title!
	}
	
	// MARK: Further functions
	
	func todaysDayName() -> String {
		
		let currentDate = NSDate()
		let dateFormatter = NSDateFormatter()
		
		// EEEE gives back the name of the day in full example Monday, Tuesday e.t.c
		dateFormatter.dateFormat = "EEEE"
		
		var todaysDayName = dateFormatter.stringFromDate(currentDate)
		
		if todaysDayName == "Sunday" || todaysDayName == "Saturday" {
			todaysDayName = "Monday"
		}
		
		return todaysDayName
		
	}
	
	func currentTime() -> Time {
		let currentDate = NSDate()
		let calendar = NSCalendar.currentCalendar()
		
		let dateComponents = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute], fromDate: currentDate)
		
		return Time(hours: dateComponents.hour, minutes: dateComponents.minute)
	}
	
	func isActiveDaySection(daySection: DaySection) -> Bool {
		let currntTime = currentTime()
		
		return (currentDay == todaysDayName() && currntTime.militaryRepresentation() >= daySection.startTime.militaryRepresentation() && currntTime.militaryRepresentation() <= daySection.endTime.militaryRepresentation())
	}
	
	
	// MARK : Animations
	
	func reloadDataAndAnimate() {
		self.tableView.reloadData()
		
		let cells = self.tableView.visibleCells
		let tableHeight: CGFloat = self.tableView.bounds.size.height
		
		// Put all the cells at the bottom of the table
		for i in cells {
			let cell: UITableViewCell = i as UITableViewCell
			cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
		}
		
		var index = 0
		
		for a in cells {
			let cell: UITableViewCell = a as UITableViewCell
			UIView.animateWithDuration(0.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
				cell.transform = CGAffineTransformMakeTranslation(0, 0)
				}, completion: nil)
			index += 1
		}
		
	}

}
