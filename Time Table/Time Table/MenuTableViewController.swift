//
//  MenuTableViewController.swift
//  Time Table
//
//  Created by Nash Vail on 07/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
	
	let menuFields = ["Today", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
	
	let cellHeight = 60
	
	var currentItem = "Monday"
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}
	
	// You can uncomment the following function to hide the status bar in this view
	/*
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	*/
	
	
  override func viewDidLoad() {
		super.viewDidLoad()

		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false

		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem()
		
		self.view.backgroundColor = UIColor.clearColor()
		self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
		self.tableView.tableFooterView = UIView(frame: CGRectZero)
		
		// Add a a little space betwene the status bar and starting of table view
		// Padding to center table view in view port 
		let paddingToCenterTableView = (self.view.bounds.size.height - CGFloat(menuFields.count * cellHeight)) / 2
		self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: paddingToCenterTableView))
		
		// Add blurred background to the table view that will make the underlying content seep in
		let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.view.bounds
		self.view.insertSubview(blurEffectView, atIndex: 0)
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 60
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
			return menuFields.count
	}

	
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("MenuTableCell", forIndexPath: indexPath) as! MenuTableCell

		// Configure the cell...
		cell.label_menuItem.text = menuFields[indexPath.row]

		return cell
	}
	
	override func viewWillAppear(animated: Bool) {
		animateTableCells()
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
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let menuTableViewController = segue.sourceViewController as! MenuTableViewController
		
		if let selectedRow = menuTableViewController.tableView.indexPathForSelectedRow?.row {
			currentItem = menuFields[selectedRow]
		}
		
	}
	
	// MARK: Animation
	
	func animateTableCells() {
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
			UIView.animateWithDuration(0.55, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
					cell.transform = CGAffineTransformMakeTranslation(0, 0)
				}, completion: nil)
			index += 1
		}
		
	}

}
