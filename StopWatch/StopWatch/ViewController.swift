//
//  ViewController.swift
//  StopWatch
//
//  Created by Nash Vail on 25/02/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var timerIsRunning = false
	var counter = 0.0
	var timer = NSTimer()
	let step = 0.1
	
	@IBOutlet var button_resumeTimer: UIButton!
	@IBOutlet var button_pauseTimer: UIButton!
	@IBOutlet var button_resetTimer: UIButton!
	@IBOutlet var label_timerDisplay: UILabel!
	
	
	@IBAction func resumeTimer(sender: AnyObject) {
		toggleTimer()
		toggleControlButtonStates()
	}
	
	@IBAction func pauseTimer(sender: AnyObject) {
		toggleTimer()
		toggleControlButtonStates()
	}
	
	@IBAction func resetTimer(sender: AnyObject) {
		timer.invalidate()
		initialize()
	}
	
	// Toggles the timer - If timer is running pauses it, if it's not starts it
	func toggleTimer() {
		if timerIsRunning {
			timer.invalidate()
		} else {
			timer = NSTimer.scheduledTimerWithTimeInterval(step, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
		}
		
		timerIsRunning = !timerIsRunning
	}
	
	// When the timer is running - Pause button is highlighted and The Play button is disabled and vice versa
	// This function handles highlighting and disabling the appropriate button depending on whether the 
	// timer is running or not.
	func toggleControlButtonStates() {
		if timerIsRunning {
			highlightButton(button_pauseTimer)
			disableButton(button_resumeTimer)
		} else {
			highlightButton(button_resumeTimer)
			disableButton(button_pauseTimer)
		}
	}
	
	// Highlights the passed in button
	// CAUTION : Behind each of the button ( play and pause ) is an UIImage
	// which which has an alpha of 0.5 and looks exactly like the button except the 0.5 alpha
	// makes it look like the disabled version of the button.
	// So to highlight or disable a button we simply show or hide the UIButton respectively.
	
	func highlightButton(button: UIButton) {
		button.hidden = false
	}
	
	func disableButton(button: UIButton) {
		button.hidden = true
	}
	
	// Updates the label that shows the timer with current time
	func updateTimer() {
		counter += 0.1
		label_timerDisplay.text = String(format: "%.1f", counter)
	}
	
	// Sets the inital value of variables and the UI state
	func initialize() {
		timerIsRunning = false
		counter = 0.0
		label_timerDisplay.text = "\(counter)"
		toggleControlButtonStates()
	}
	
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		initialize()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

