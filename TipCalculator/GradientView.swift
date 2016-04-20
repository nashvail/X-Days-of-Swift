//
//  GradientView.swift
//  TipCalculator
//
//  Created by Nash Vail on 20/04/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
	let gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer()
		
		let colors = [
			UIColor(red:0.08, green:0.48, blue:0.49, alpha:1.00).CGColor,
			UIColor(red:0.01, green:0.67, blue:0.44, alpha:1.00).CGColor
		]
		
		gradientLayer.colors = colors
		
		let locations = [0, 0.6]
		gradientLayer.locations = locations
		
		return gradientLayer
	}()
	
	override func layoutSubviews() {
		gradientLayer.frame = bounds
	}
	
	override func didMoveToWindow() {
		super.didMoveToWindow()
		layer.addSublayer(gradientLayer)
	}
}
