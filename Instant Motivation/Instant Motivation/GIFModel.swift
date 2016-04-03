//
//  GIFModel.swift
//  Instant Motivation
//
//  Created by Nash Vail on 03/04/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import Foundation

struct GIF {
	var name: String
	var imageNamePrefix: String
	var numFrames: Int
	var fps: Double
	var audio: AVAudioFile
}

struct AVAudioFile {
	var name: String
	var type: String
}
