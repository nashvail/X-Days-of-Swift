//
//  ViewController.swift
//  SingleMusicPlayer
//
//  Created by Nash Vail on 17/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	var player:AVAudioPlayer = AVAudioPlayer()
	
	// MARK: IBOutlets
	@IBOutlet var playButton:PlayButtonView!
	@IBOutlet var progressArc:ProgressArcView!
	
	// MARK: Class Variables
	var currentProgress = 0
	var isPlaying = false
	
	@IBAction func play(sender: AnyObject) {
		// Let us take a simple route here 
		if isPlaying {
			player.pause()
		} else {
			player.play()
		}
		
		isPlaying = !isPlaying
		playButton.isInPlayingState = isPlaying
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		progressArc.arcColor = RGB(34, green: 147, blue: 251)
		initAudioFile(fileName: "bach", type: "mp3")
		
		// Updates progress arc every 0.05 seconds
		_ = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "updateProgressArc", userInfo: nil, repeats: true)
		
		// Let us just add and animate ripples here, first of try to add a view dynamically
		_ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "createRipple", userInfo: nil, repeats: true)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: Further Methods
	
	// Initializes the audio file that is to be played in the app
	func initAudioFile(fileName fileName: String, type: String) {
		do {
		try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: type)!))
		} catch {
			// Handle any errors if this happens
			print("Didn't freaking work")
		}
	}
	
	func updateProgressArc() {
		progressArc.percentProgress = Float((player.currentTime / player.duration)) * 100.0
	}
	
	func addRippleCircle() -> CircleView {
		let circle = CircleView(frame: progressArc.frame, strokeWidth: 1)!
		circle.center = self.view.center
		self.view.insertSubview(circle, aboveSubview: progressArc)
		
		return circle
	}
	
	func animateRipple(rippleCircle: CircleView) {
		rippleCircle.alpha = 1.0
		
		UIView.animateWithDuration(4, delay: 0.0, options: [.CurveEaseInOut], animations: { () -> Void in
  		rippleCircle.transform = CGAffineTransformMakeScale(4, 4)
  		rippleCircle.alpha -= 1.0
			}, completion: { _ -> Void in
				rippleCircle.removeFromSuperview()
		})
		
	}
	
	func createRipple() {
		if isPlaying {
  		animateRipple(addRippleCircle())
		}
	}


}

