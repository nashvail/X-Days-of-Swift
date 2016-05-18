//
//  ViewController.swift
//  HackerNewsReader
//
//  Created by Nash Vail on 06/05/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

// MARK: Global vars 
var currentStoryUrl: String!

class ViewController: UIViewController, UITableViewDelegate {
	
	var refreshControl: UIRefreshControl!
	var customView: UIView!
	var labelsArray: Array<UILabel> = []
	
	var timer: NSTimer!
	
	
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

	// MARK: Overriden methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Setting styles for the table view
		tableView_articles.separatorStyle = .None
		
		refreshControl = UIRefreshControl()
		tableView_articles.addSubview(refreshControl)
		
//		loadCustomRefreshContents()
		
		loadStories()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func viewWillAppear(animated: Bool) {
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	override func viewDidDisappear(animated: Bool) {
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	// MARK: Table View Methods
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int	 {
		return stories.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView_articles.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArticleCell
		
		let currentStory = stories[indexPath.row]
		
		cell.label_articleTitle.text = currentStory["title"]
		cell.label_articleVotes.text = currentStory["score"]
		
		if let storyUrl = currentStory["url"] {
  		cell.label_articleSource.text = urlDomain(storyUrl)
		} else {
			cell.label_articleSource.text = ""
		}
		
		cell.accessoryType = .DisclosureIndicator
		return cell
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 84.0
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		currentStoryUrl = stories[indexPath.row]["url"]
	}
	
	// MARK: Scroll View methods 
	
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		// This is where you have to start the custom refresh animation
		if refreshControl.refreshing {
  		loadStories()
		}
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
	
	/**
	Given a URL, returns the domain of the URL
	*/
	func urlDomain(source: String) -> String {
		if let url = NSURL(string: source) {
			if let host = url.host{
				return host
			} else {
				return ""
			}
		} else {
			return ""
		}
	}
	
	func loadStories() {
		// Grabbing data from the end point
		if let url = NSURL(string: url_topStoriesIds) {
			if let data = try? NSData(contentsOfURL: url, options: []) {
				let json = JSON(data: data)
				parseJSON(json)
				
				if refreshControl.refreshing {
					refreshControl.endRefreshing()
				}
				
			}
		}
	}
	
	func loadCustomRefreshContents() {
		
	}
	
}

