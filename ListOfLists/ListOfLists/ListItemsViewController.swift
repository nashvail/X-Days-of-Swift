//
//  ListItemsViewController.swift
//  ListOfLists
//
//  Created by Nash Vail on 10/06/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit
import CoreData

class ListItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var listItems = NSMutableArray(array: [ListItem]())
	
	@IBOutlet var listItemsTable: UITableView!

	@IBAction func addNewListItem(sender: AnyObject) {
		
		let alert = UIAlertController(title: "Add Item", message: "Enter name of the new item", preferredStyle: .Alert)
		
		let saveAction = UIAlertAction(title: "Save", style: .Default) { (action) in
			// Gotta do something here
			let textField = alert.textFields?.first
			self.saveNewItem((textField?.text)!)
			self.listItemsTable.reloadData()
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
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
		title = selectedList.name
		
		listItems = NSMutableArray(array: (selectedList.listitem?.allObjects)!)
		
  }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
  }
	
	// MARK: Table View Methods
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listItems.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = listItemsTable.dequeueReusableCellWithIdentifier("ListItemCell")! as UITableViewCell
		cell.textLabel?.text = listItems[indexPath.row].value
		return cell
	}
	
	// MARK: Core Data Methods
	
	func saveNewItem(itemName: String) {
		let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = delegate.managedObjectContext
		
		let listItem = NSEntityDescription.insertNewObjectForEntityForName("ListItem", inManagedObjectContext: managedContext) as! ListItem
		listItem.value = itemName
		listItem.list = selectedList
		
		listItems.addObject(listItem)
		
		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Error saving new list item \(error.userInfo)")
		}
		
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		
		if editingStyle == .Delete {
			deleteListItem(indexPath)
		}
		
	}
	
	// MARK: Custom Methods 
	
	func deleteListItem(listItemIndexPath: NSIndexPath) {
		
		// 1
		let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = delegate.managedObjectContext
		
		// 2
		managedContext.deleteObject(listItems[listItemIndexPath.row] as! NSManagedObject)
		listItems.removeObject(listItems[listItemIndexPath.row])
		listItemsTable.deleteRowsAtIndexPaths([listItemIndexPath], withRowAnimation: .Automatic)
		
		// 3
		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Error saving \(error.userInfo)")
		}
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
