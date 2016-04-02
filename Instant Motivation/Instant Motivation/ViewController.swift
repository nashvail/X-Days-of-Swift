//
//  ViewController.swift
//  Instant Motivation
//
//  Created by Nash Vail on 02/04/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	// MARK: Animation Properties
	var timer = NSTimer()
	let fps:Double = 35
	var currentFrame = 0
	var isPlaying = false
	
	// MARK: GIF Properties
	var GIFs = [GIF(name: "Just Do It", imageNamePrefix: "justdoit_1_frame_", numFrames: 60, audio: AVAudioFile(name: "first", type: "aiff"))]
	var randomGIF: GIF!
	
	// MARK: Audio Properties 
	var audioPlayer: AVAudioPlayer = AVAudioPlayer()
	
	
	@IBOutlet var motivationImage: UIImageView!
	
	// MARK: Overriden methods

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		randomGIF = GIFs[0]
		initAudioFile(fileName: randomGIF.audio.name, type: randomGIF.audio.type)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	
	// MARK: Custom methods
	
	func playGIF() {
		startGIFAnimation()
		startGIFAudio()
		isPlaying = true
	}
	
	func stopGIF() {
		stopGIFAnimation()
		isPlaying = false
	}
	
	func startGIFAnimation() -> Void {
		currentFrame = 0
		timer = NSTimer.scheduledTimerWithTimeInterval(1/fps, target: self, selector: #selector(ViewController.animateImage), userInfo: nil, repeats: true)
	}
	
	func stopGIFAnimation() {
		timer.invalidate()
	}
	
	func startGIFAudio() {
		audioPlayer.play()
	}
	
	func animateImage() {
		updateImageToFrame(currentFrame)
		currentFrame += 1
		if currentFrame > randomGIF.numFrames {
			stopGIF()
		}
	}
	
	func updateImageToFrame(frameNumber: Int) {
		let properFrameNumber = frameNumber % randomGIF.numFrames
		motivationImage.image = UIImage(named: "\(randomGIF.imageNamePrefix)\(properFrameNumber).png")
	}
	
	// Initializes the audio file that is to be played in the app
	func initAudioFile(fileName fileName: String, type: String) {
		do {
			try audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: type)!))
		} catch {
			// Handle any errors if this happens
			print("There was an error retrieving the file, maybe it doesn't exist")
		}
	}
	
	// MARK: Methods detecting Gestures and shakes
	
	override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
		if event?.subtype == UIEventSubtype.MotionShake{
			if !isPlaying {
				playGIF()
			}
		}
	}
	
	
}

