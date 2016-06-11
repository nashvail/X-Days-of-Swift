//
//  ViewController.swift
//  ListOfLists
//
//  Created by Nash Vail on 10/06/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit
import CoreData

var selectedList: List!

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	// MARK: IBOutlets
	@IBOutlet var listsTable: UITableView!
	
	// MARK: IBActions
	@IBAction func addNewList(sender: AnyObject) {
		
		let alert = UIAlertController(title: "Add List", message: "Enter name of the new list", preferredStyle: .Alert)
		
		let saveAction = UIAlertAction(title: "Save", style: .Default) { (action) in
			// Gotta do something here
			let textField = alert.textFields?.first
			self.saveNewList((textField?.text)!)
			self.listsTable.reloadData()
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action) in
			// Do nothing
		}
		
		alert.addTextFieldWithConfigurationHandler { (textField) in
			// Do nothing
		}
		
		alert.addAction(saveAction)
		alert.addAction(cancelAction)
		
		presentViewController(alert, animated: true) { 
			// Do nothing
		}
	
	}
	
	// MARK: Properties 
	
	var lists = [List]()
	
	// MARK: Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		title = "Lists"
		
		// Fetch Lists from CoreData
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let managedObjectContext = appDelegate.managedObjectContext
		
		let fetchRequest = NSFetchRequest(entityName: "List")
		
		do {
			lists = try managedObjectContext.executeFetchRequest(fetchRequest) as! [List]
		} catch let error as NSError {
			print("There was an error fetching data \(error.userInfo)")
		}
		
	}
	
	override func viewWillAppear(animated: Bool) {
		// Manually deselect the previously selected row in table
		let selectedIndexPath = self.listsTable.indexPathForSelectedRow
		
		if let rowToDeselect = selectedIndexPath {
			self.listsTable.deselectRowAtIndexPath(rowToDeselect, animated: true)
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: TableView Methods
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return lists.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = listsTable.dequeueReusableCellWithIdentifier("ListCell")! as UITableViewCell
		cell.textLabel?.text = lists[indexPath.row].name
		cell.accessoryType = .DisclosureIndicator
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		selectedList = lists[indexPath.row]
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		
		if editingStyle == .Delete {
			deleteList(indexPath)
		} else {
			print("Erorr: Unhandled editing style")
		}
		
	}
	
	// MARK: CoreData Methods
	
	func saveNewList(listName: String) {
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext
		
		var list = NSEntityDescription.insertNewObjectForEntityForName("List", inManagedObjectContext: managedContext) as! List
		list.name = listName
		
		lists.append(list)
		
		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Error saving data \(error.userInfo)")
		}
		
	}
	
	// MARK: Custom Methods 
	
	func deleteList(listIndexPath: NSIndexPath) {
		// 1
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext
		
		// 2
		managedContext.deleteObject(lists[listIndexPath.row])
		lists.removeAtIndex(listIndexPath.row)
		listsTable.deleteRowsAtIndexPaths([listIndexPath], withRowAnimation: .Automatic)
		
		// 3 
		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Error saving \(error.userInfo)")
		}
		
	}

}

