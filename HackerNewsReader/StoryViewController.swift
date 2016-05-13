//
//  StoryViewController.swift
//  HackerNewsReader
//
//  Created by Nash Vail on 08/05/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

	@IBOutlet var webView_story: UIWebView!
  override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
		
		if currentStoryUrl != nil {
			let url = NSURL(string: currentStoryUrl)
			let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {(data, response, error) -> Void in
				
				if let urlContent = data {
					let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
					// Will dispatch the queue and end everything as soonView as the data is downloaded
					dispatch_async(dispatch_get_main_queue(), {
						self.webView_story.loadHTMLString(String(webContent!), baseURL: nil)
					})
				}
			})
			
			task.resume()
			
		}
		
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
