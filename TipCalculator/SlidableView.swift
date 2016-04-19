//
//  SlidableView.swift
//  TipCalculator
//
//  Created by Nash Vail on 18/04/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

class SlidableView: UIControl {
	
	// MARK: Properties
	
	private var _backingValue: Float = 0.0
	
	var valueLabel: UILabel = UILabel()
	
	// MARK: Computed properties 
	
	var value: Float {
		get { return _backingValue }
		set {
			_backingValue = newValue
			updateValueLabel(newValue)
		}
	}
	
	// MARK: Methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		addValueLabel(frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func addValueLabel(frame: CGRect) {
		valueLabel = UILabel(frame: frame)
		valueLabel.text = "\(value)"
		valueLabel.textAlignment = .Center
		valueLabel.textColor = UIColor.whiteColor()
		valueLabel.backgroundColor = UIColor.clearColor()
		valueLabel.font = UIFont(name: "Avenir Next", size: 24.0)
		
		self.addSubview(valueLabel)
		
	}
	
	
	// MARK: Methods for tracking touch on the view 
	
	var prevTouchX: CGFloat = 0.0
	
	var currentSection = 0
	
	override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
		prevTouchX = touchX(touch)
		currentSection = 0
		return true
	}
	
	override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
		
		let result = valueShouldChange(delta(touchX(touch), second: prevTouchX))
		
		if result.shouldChange {
			value = value + (Float(result.multiplier) * 1)
		}
	
		return true
		
	}
	
	override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
	}
	
	// MARK: Custom methods
	
	func updateValueLabel(value: Float) {
		if value >= 0 {
  		valueLabel.text = "\(value)"
		}
	}
	
	func touchX(touch: UITouch) -> CGFloat {
		return touch.locationInView(self).x
	}
	
	func delta(first: CGFloat, second: CGFloat) -> Float {
		return Float(first - second)
	}
	
	func valueShouldChange(totalPointsDragged: Float) -> (shouldChange: Bool, multiplier: Int) {
		let N: Float = 15.0
		
		let K = (100 * totalPointsDragged) / N
		let section = Int(K/100)
		
		if section != currentSection { // So the section has changed, now its for us to decide whether increased or decreased
			if section > currentSection {
				currentSection = section
				return (true, 1)
			} else if section < currentSection {
				currentSection = section
				return (true, -1)
			}
		}
		
		return (false, 0)
	}
	
}
