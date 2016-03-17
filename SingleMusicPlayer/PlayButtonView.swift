//
//  PlayButtonView.swift
//  SingleMusicPlayer
//
//  Created by Nash Vail on 17/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

@IBDesignable
class PlayButtonView: UIButton {
	
	@IBInspectable var buttonColor: UIColor = RGB(48, green: 48, blue: 48)
	
	// Variables to configure shadow of the button
	@IBInspectable var shadowOffsetWidth: Int = 0
	@IBInspectable var shadowOffsetHeight: Int = 3
	@IBInspectable var shadowColor: UIColor? = UIColor.blackColor()
	@IBInspectable var shadowOpacity: Float = 0.5
	@IBInspectable var shadowRadius: CGFloat = 0.0
	
	// So that the shadow of the button is not clipped off by the containing frame
	// we will draw the button smaller than the size of the actual frame
	let paddingInContainer:CGFloat = 30
	
	var buttonRect:CGRect!
	
	
	// Redraw the button as a filled circle
	override func drawRect(rect: CGRect) {
		let path = UIBezierPath(ovalInRect: rect)
		buttonColor.setFill()
		path.fill()
		
		
		// Draw the button shadow
		let shadowPath = UIBezierPath(ovalInRect: rect)
		
		layer.masksToBounds = false
		layer.shadowColor = shadowColor?.CGColor
		layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
		layer.shadowOpacity = shadowOpacity
		layer.shadowRadius = shadowRadius
		layer.shadowPath = shadowPath.CGPath
	}
}
