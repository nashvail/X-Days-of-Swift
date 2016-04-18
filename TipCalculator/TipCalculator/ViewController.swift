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
	
	var tempSlidableView: SlidableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewDidLayoutSubviews() {
		tempSlidableView = SlidableView(frame: tempPlaceHolder.bounds)
		tempPlaceHolder.addSubview(tempSlidableView)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

