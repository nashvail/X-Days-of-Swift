//
//  ProgressArcView.swift
//  SingleMusicPlayer
//
//  Created by Nash Vail on 17/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

@IBDesignable
class ProgressArcView: UIView {
	
	let π:CGFloat = CGFloat(M_PI)
	let stepAngle = CGFloat(M_PI)/16
	
	@IBInspectable var percentProgress: Float = 10 {
		didSet {
			setNeedsDisplay()
		}
	}
	
	@IBInspectable var arcColor = RGB(246, green: 224, blue: 50)
	
	override func drawRect(rect: CGRect) {
		
		let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
		let radius = max(bounds.width, bounds.height)
		
		let arcWidth: CGFloat = 76
		
		let startAngle: CGFloat = 3 * π / 2
		let endAngle: CGFloat = startAngle + progressInAngle(percentProgress)
		
		let path = UIBezierPath(arcCenter: center,
			radius: radius/2 - arcWidth/2,
			startAngle: startAngle,
			endAngle: endAngle,
			clockwise: true)
		
		// 6
		path.lineWidth = arcWidth
		arcColor.setStroke()
		path.stroke()
	}
	
	// MARK: Further functions 
	func progressInAngle(percentProgress: Float) -> CGFloat {
		
		if percentProgress >= 100 {
			return CGFloat(2*π)
		}
		
		let fractionProgress = CGFloat(percentProgress / 100)
		return ( fractionProgress * 2 * π )
	}
	
}
