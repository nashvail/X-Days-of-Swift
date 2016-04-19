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
	
	// MARK: Computed properties
	
	var value: Float {
		get { return _backingValue }
		set {
			_backingValue = newValue
		}
	}
	
	/** Number of points the finger is dragged across the view to increment or decrement the value by 1 */
	var step: Float = 15.0
	
	// MARK: Methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		//addValueLabel(frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(frame: CGRect, step: Float) {
		self.init(frame: frame)
		self.step = step
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
			if value <= 0 {
				value = 0
			}
			sendActionsForControlEvents(.ValueChanged)
		}
	
		return true
		
	}
	
	// MARK: Custom methods
	
	func touchX(touch: UITouch) -> CGFloat {
		return touch.locationInView(self).x
	}
	
	func delta(first: CGFloat, second: CGFloat) -> Float {
		return Float(first - second)
	}
	
	func valueShouldChange(totalPointsDragged: Float) -> (shouldChange: Bool, multiplier: Int) {
		let K = (100 * totalPointsDragged) / step
		let section = Int(K/100)
		
		if section != currentSection {
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
