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
	
	@IBOutlet var placeHolderTipPercentageSelector: UIView!
	@IBOutlet var placeHolderNumSplitSelector: UIView!
	
	
	
	@IBAction func addDigitToDisplay(sender: AnyObject) {
		print("A button on keypad was pressed")
	}
	
	var tempSlidableView: SlidableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		//tempSlidableView = SlidableView(frame: tempPlaceHolder.bounds)
		//tempPlaceHolder.addSubview(tempSlidableView)
		
		//tempSlidableView.addTarget(self, action: #selector(ViewController.updateTesterLabel), forControlEvents: .ValueChanged)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: Custom methods
	
	func updateTesterLabel() {
		//let currentSlidableViewValue = Int(tempSlidableView.value)
		//testerLabel.text = "\(currentSlidableViewValue)"
	}


}

