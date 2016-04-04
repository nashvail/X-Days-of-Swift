//
//  CircleView.swift
//  Instant Motivation
//
//  Created by Nash Vail on 04/04/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {
	
	@IBInspectable var bgColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
	
	override func drawRect(rect: CGRect) {
		let path = UIBezierPath(ovalInRect: rect)
		bgColor.setFill()
		path.fill()
	}

}
