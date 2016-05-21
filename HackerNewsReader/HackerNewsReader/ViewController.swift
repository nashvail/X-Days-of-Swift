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
	
	// For putting in the refresh control
	var ovalLayer: CAShapeLayer = CAShapeLayer()
	
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
		refreshControl.clipsToBounds = true
		tableView_articles.addSubview(refreshControl)
		
//		loadCustomRefreshControlContents()
		
		loadStories()
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func viewWillAppear(animated: Bool) {
		navigationController?.setNavigationBarHidden(true, animated: true)
		
		// Manually deselect the previously selected row in table 
		let selectedIndexPath = self.tableView_articles.indexPathForSelectedRow
		
		if let rowToDeselect = selectedIndexPath {
  		self.tableView_articles.deselectRowAtIndexPath(rowToDeselect, animated: true)
		}
		
		
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
		if refreshControl.refreshing {
  		loadStories()
		}
	}
	
	// You can fire your animation here also
	func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		// This is where you have to start the custom refresh animation
		let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
		strokeStartAnimation.fromValue = -0.5
		strokeStartAnimation.toValue = 1.0
		
		let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
		strokeEndAnimation.fromValue = 0.0
		strokeEndAnimation.toValue = 1.0
		
		let strokeAnimationGroup = CAAnimationGroup()
		strokeAnimationGroup.duration = 0.9
		strokeAnimationGroup.repeatDuration = 5.0
		strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
		
		ovalLayer.addAnimation(strokeAnimationGroup, forKey: nil)
		
	}
	
	func scrollViewDidScroll(scrollView: UIScrollView) {
		// Get the current size of the refresh controller
		let refreshBounds = refreshControl!.bounds;
		
		// Distance the table has been pulled >= 0
		let pullDistance = max(0.0, -refreshControl!.frame.origin.y);
		
		// Pull ratio is between 0 and 1
		let pullRatio = min( max(pullDistance, 0.0), 100.0) / 100.0;
		
		redrawFromProgress(pullRatio)
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
		// Empty the dictionary holding stories 
		stories.removeAll()
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
	
	func loadCustomRefreshControlContents() {
		// Let us first set up a circle in the refresh View 
		refreshControl.backgroundColor = UIColor.whiteColor()
		refreshControl.tintColor = UIColor.clearColor()
		refreshControl.clipsToBounds = true
		
		ovalLayer.strokeColor = UIColor.blackColor().CGColor
		ovalLayer.fillColor = UIColor.clearColor().CGColor
		ovalLayer.lineWidth = 2.0
		
		let refreshRadius = refreshControl.frame.height/2.0 * 0.6
		
		ovalLayer.path = UIBezierPath(
			arcCenter: CGPoint(x: refreshControl.frame.width/4 + (2 * ovalLayer.lineWidth), y: refreshControl.frame.height/2),
			radius: refreshRadius,
			startAngle: CGFloat(-M_PI_2),
			endAngle: CGFloat(-M_PI_2 - 2 * M_PI),
			clockwise: false).CGPath
	
		refreshControl.layer.addSublayer(ovalLayer)
	}
	
	// For custom refresh control animation (not implemented)
	func redrawFromProgress(progress: CGFloat) {
		ovalLayer.strokeEnd = progress
	}
}

