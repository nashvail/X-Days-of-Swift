//
//  TimeTableViewController.swift
//  Time Table
//
//  Created by Nash Vail on 06/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

class TimeTableViewController: UITableViewController {

	var defaultColor = UIColor(red: 66/255.0, green: 73/255.0, blue: 59/255.0, alpha: 1)
	var cellColors = ["#C3D8B9", "#BCD2B0", "#AEC4A4", "#9EB394", "#7BA07D", "#6F8A67", "#505D41", "#43483B"]
	
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
			return 8
	}


	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("timeTableCell", forIndexPath: indexPath) as! TimeTableViewCell
		cell.label_time.text = "8:30 AM - 9:34 PM"
		cell.label_subjectName.text = "Theoretical Computer Science"
		return cell
	}
	
	override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
		cell.backgroundColor = colorForCellAtIndex(index: indexPath.row)
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
	
	// Converts HEX String to UIColor
	func colorWithHexString (hex:String) -> UIColor {
		var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
		
		if (cString.hasPrefix("#")) {
			cString = (cString as NSString).substringFromIndex(1)
		}
		
		if (cString.characters.count != 6) {
			return UIColor.grayColor()
		}
		
		let rString = (cString as NSString).substringToIndex(2)
		let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
		let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
		
		var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
		NSScanner(string: rString).scanHexInt(&r)
		NSScanner(string: gString).scanHexInt(&g)
		NSScanner(string: bString).scanHexInt(&b)
		
		
		return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
	}

}
