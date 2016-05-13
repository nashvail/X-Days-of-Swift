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
	
	// MARK: Properties 
	let numTopStoriesToFetch = 10
	var stories = [[String: String]]()
	
	// MARK: JSON fetching endpoints
	let url_topStoriesIds = "https://hacker-news.firebaseio.com/v0/topstories.json"
	
	func url_story(id: String) -> String {
		return "https://hacker-news.firebaseio.com/v0/item/\(id).json"
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Setting styles for the table view
		tableView_articles.separatorStyle = .None
		
		// Grabbing data from the end point 
		if let url = NSURL(string: url_topStoriesIds) {
			if let data = try? NSData(contentsOfURL: url, options: []) {
				let json = JSON(data: data)
				parseJSON(json)
			}
		}
		
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
		return stories.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView_articles.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArticleCell
		
		let currentStory = stories[indexPath.row]
		
		cell.label_articleTitle.text = currentStory["title"]
		cell.label_articleSource.text = urlDomain(currentStory["url"]!)
		cell.label_articleVotes.text = currentStory["score"]
		cell.accessoryType = .DisclosureIndicator
		return cell
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 84.0
	}
	
	// MARK: JSON methods 
	func parseJSON(json: JSON) {
		
		// Get title, score and url of the top "numTopStoriesToFetch" stories
		
		for var i in 0...numTopStoriesToFetch - 1 {
			
			let currentStoryId = json[i].stringValue
			let currentStoryEndpoint = url_story(currentStoryId)
			
			if let url = NSURL(string: currentStoryEndpoint) {
				if let data = try? NSData(contentsOfURL: url, options: []) {
					
					let json = JSON(data: data)
					
					let title = json["title"].stringValue
					let score = json["score"].stringValue
					let url = json["url"].stringValue
					
					let story = ["title": title, "score": score, "url": url]
					
					stories.append(story)
					
				}
			}
			
		}
		
		tableView_articles.reloadData()
		
	}
	
	// MARK: Custom methods 
	func urlDomain(url: String) -> String {
		return NSURL(string: url)!.host!
	}
	
}

