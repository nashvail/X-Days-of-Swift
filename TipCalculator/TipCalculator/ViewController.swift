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
	@IBOutlet var tempPlaceHolder: UIView!
	@IBOutlet var testerLabel: UILabel!
	
	var tempSlidableView: SlidableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		tempSlidableView = SlidableView(frame: tempPlaceHolder.bounds, step: 20)
		tempPlaceHolder.addSubview(tempSlidableView)
		
		tempSlidableView.addTarget(self, action: #selector(ViewController.updateTesterLabel), forControlEvents: .ValueChanged)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: Custom methods
	
	func updateTesterLabel() {
		let currentSlidableViewValue = Int(tempSlidableView.value)
		testerLabel.text = "\(currentSlidableViewValue)"
	}


}

