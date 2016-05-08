//
//  ViewController.swift
//  HackerNewsReader
//
//  Created by Nash Vail on 06/05/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
	
	// MARK: IBOutlets
	@IBOutlet var tableView_articles: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Setting styles for the table view
		tableView_articles.separatorStyle = .None
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func viewWillAppear(animated: Bool) {
		navigationController?.setNavigationBarHidden(true, animated: true)
		navigationController?.hidesBarsOnSwipe = false
	}
	
	override func viewDidDisappear(animated: Bool) {
		navigationController?.setNavigationBarHidden(false, animated: true)
		navigationController?.hidesBarsOnSwipe = true
	}
	
	
	
	// MARK: Table View Methods
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int	 {
		return 2
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView_articles.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArticleCell
		cell.label_articleTitle.text = "Title of the article"
		cell.label_articleSource.text = "mgcm.com"
		cell.label_articleVotes.text = "\(252)"
		cell.accessoryType = .DisclosureIndicator
		return cell
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 84.0
	}
	
}

