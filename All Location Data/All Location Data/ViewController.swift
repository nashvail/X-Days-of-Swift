//
//  ViewController.swift
//  All Location Data
//
//  Created by Nash Vail on 27/02/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

	@IBOutlet var label_city: UILabel!
	@IBOutlet var label_country: UILabel!
	@IBOutlet var label_pincode: UILabel!
	@IBOutlet var label_latitude: UILabel!
	@IBOutlet var label_longitude: UILabel!
	@IBOutlet var label_altitude: UILabel!
	@IBOutlet var label_course: UILabel!
	@IBOutlet var label_state: UILabel!
	
	var locationManager:CLLocationManager!
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// Setup the location manager 
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		
	}
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		let userLocation:CLLocation = locations[0]
		
		// Update the Longitude and Latitude
		self.label_latitude.text = String(format:"%.3f", userLocation.coordinate.latitude)
		self.label_longitude.text = String(format:"%.3f", userLocation.coordinate.longitude)
		
		// Update the Altitude and Course
		self.label_altitude.text = String(format: "%.3f", userLocation.altitude)
		updateLabelTextWithDouble(self.label_course, text: userLocation.course)
		
		// Reverse Geocode to find the city country and pincode
		CLGeocoder().reverseGeocodeLocation(userLocation) { (placeMarks, error) -> Void in
			if error != nil {
				print(error)
				return
			}
			
			if placeMarks!.count > 0 {
				
				let p = placeMarks![0]
				self.updateLabelText(self.label_state, text: p.administrativeArea!)
				self.updateLabelText(self.label_city, text: p.subAdministrativeArea!)
				self.updateLabelText(self.label_country, text: p.country!)
				self.updateLabelText(self.label_pincode, text: p.postalCode!)
				
			} else {
				print("There was an error retreiving the location")
			}
		}
		
	}
	
	func updateLabelTextWithDouble(label: UILabel, text: Double) -> Void {
		label.text = "\(text)"
	}
	
	func updateLabelText(label: UILabel, text: String) -> Void {
		label.text = text
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

