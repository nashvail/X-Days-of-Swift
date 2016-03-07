//
//  NavigationController.swift
//  Time Table
//
//  Created by Nash Vail on 06/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		/*
		let sampleLabel = UILabel(frame: self.navigationBar.frame)
		sampleLabel.text = "Monday"
		sampleLabel.font = UIFont(name: "Avenir Next Condensed", size: 18.0)
		sampleLabel.textColor = UIColor.whiteColor()
		
		self.navigationBar.addSubview(sampleLabel)
		*/
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	

	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
			// Get the new view controller using segue.destinationViewController.
			// Pass the selected object to the new view controller.
	}
	*/

}
