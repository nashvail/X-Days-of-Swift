//
//  ViewController.swift
//  TipCalculator
//
//  Created by Nash Vail on 18/04/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	// MARK: IBOutlets
	@IBOutlet var label_amountDisplay: UILabel!
	@IBOutlet var label_tipPercentageDisplay: UILabel!
	@IBOutlet var label_tipDisplay: UILabel!
	@IBOutlet var label_numSplitDisplay: UILabel!
	@IBOutlet var label_currentTipDisplay: UILabel!
	
	@IBOutlet var placeHolderTipPercentageSelector: UIView!
	@IBOutlet var placeHolderNumSplitSelector: UIView!
	
	
	
	@IBAction func addDigitToDisplay(sender: AnyObject) {
		print("A button on keypad was pressed")
	}
	
	// MARK: Slidable Views
	var tipPercentageSlidableView: SlidableView!
	var numSplitSlidableView: SlidableView!


	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		tipPercentageSlidableView = SlidableView(frame: placeHolderTipPercentageSelector.bounds)
		numSplitSlidableView = SlidableView(frame: placeHolderNumSplitSelector.bounds, step: 30)
		
		placeHolderTipPercentageSelector.addSubview(tipPercentageSlidableView)
		placeHolderNumSplitSelector.addSubview(numSplitSlidableView)
		
		// Add slider value change listeners to the slidable views 
		tipPercentageSlidableView.addTarget(self, action: #selector(ViewController.updateTipPercentage), forControlEvents: .ValueChanged)
		numSplitSlidableView.addTarget(self, action: #selector(ViewController.updateNumSplits), forControlEvents: .ValueChanged)
		
		//tempSlidableView.addTarget(self, action: #selector(ViewController.updateTesterLabel), forControlEvents: .ValueChanged)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}
	
	// MARK: Slidable view value change listeners
	
	func updateTipPercentage() {
		print(tipPercentageSlidableView.value)
	}
	
	func updateNumSplits() {
		print(numSplitSlidableView.value)
	}

}

