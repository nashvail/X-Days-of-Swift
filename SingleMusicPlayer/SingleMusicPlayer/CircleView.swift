//
//  CircleView.swift
//  SingleMusicPlayer
//
//  Created by Nash Vail on 18/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//
// Exports CircleView, a UIView that is a circle. That's it man

import UIKit

@IBDesignable
class CircleView: UIView {
	
	@IBInspectable var strokeColor: UIColor = RGB(151, green: 151, blue: 151)
	@IBInspectable var strokeWidth:CGFloat = 3
	
	let π = CGFloat(M_PI)
	
	override func drawRect(rect: CGRect) {
		let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
		let radius = max(bounds.width, bounds.height)
		
		let startAngle:CGFloat = 0
		let endAngle = startAngle + (2 * π)
		
		var path = UIBezierPath(arcCenter: center, radius: radius/2 - strokeWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
		
		path.lineWidth = strokeWidth
		strokeColor.setStroke()
		path.stroke()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.clearColor()
	}
	
	init?(frame: CGRect, strokeWidth: CGFloat) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.clearColor()
		self.strokeWidth = strokeWidth
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

}
