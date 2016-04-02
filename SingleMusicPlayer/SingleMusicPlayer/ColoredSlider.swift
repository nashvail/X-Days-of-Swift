//
//  ColoredSlider.swift
//
//  Created by Nash Vail on 27/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//	------------------------------------------------------------------
//
// Exports a Slider UI Component, same as the default iOS component, except
// that you have control over the color and size of the stick and thumb of the slider.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

// Clamps value in between minValue and maxValue.
func clamp(value: Float, minValue: Float, maxValue: Float) -> Float {
	return min(maxValue, max(minValue, value))
}

class ColoredSlider: UIControl {
	
	// MARK: Properties
	
	// MARK: Stored Properties 
	
	private var renderer = ColoredSliderRenderer()
	
	private var _backingValue: Float = 0.0
	private var _minimumValue: Float = 0.0
	private var _maximumValue: Float = 1.0
	private var _color: UIColor = UIColor.blackColor()
	

	// MARK: Computed Properties
	
	var value: Float {
		get { return _backingValue }
		set {
			_backingValue = clamp(newValue, minValue: minimumValue, maxValue: maximumValue)
			
			// Position the thumb in the slider on value change
			renderer.thumbPosition = valueInPercentageOfMax(_backingValue)
		}
	}
	
	var minimumValue: Float {
		return _minimumValue
	}
	
	var maximumValue: Float {
		return _maximumValue
	}
	
	var color: UIColor {
		return _color
	}
	
	// MARK: Methods
	
	// MARK: Initializers
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		// Draws the thumb and the stick of the slider
		drawSubLayers()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init!(frame: CGRect, minimumValue: Float, maximumValue: Float, color: UIColor) {
		self.init(frame: frame)
		
		// If naughty hobbitses try to make minimumValue greater than maximumValue, fail the intializer
		if minimumValue >= maximumValue {
			print("Error : Value of maximumValue should be greater than minimumValue")
			return nil
		}
		
		// Initialize the properties
		self._minimumValue = minimumValue
		self._maximumValue = maximumValue
		self._color = color
		// Initially place the thumb at the center of the stick
		self.value = (maximumValue + minimumValue) / 2
	}
	
	// MARK: Custom Methods
	private func drawSubLayers() {
		renderer.update(bounds)
		renderer.stickColor = color
		renderer.thumbFillColor = color
		renderer.thumbStrokeColor = color
		
		layer.addSublayer(renderer.stickLayer)
		layer.addSublayer(renderer.thumbLayer)
	}
	
	private func valueInPercentageOfMax(value: Float) -> Float {
		return ((value - _minimumValue) / (_maximumValue - _minimumValue))
	}
	
	// MARK: Methods concerning touch tracking

	override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
		return renderer.thumbLayer.frame.contains(touch.locationInView(self))
	}
	
	override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
		let locationWithinBounds = clamp(Float(touch.locationInView(self).x), minValue: 0.0, maxValue: Float(renderer.stickLength))
		
		// Disable implicit animations
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		self.value = minimumValue + ((locationWithinBounds / Float(renderer.stickLength)) * (maximumValue - minimumValue))
		sendActionsForControlEvents(.ValueChanged)
		
		CATransaction.commit()
		return true
	}
	
}

private class ColoredSliderRenderer {
	
	// MARK: Properties
	
	private let thumbLayer = CAShapeLayer()
	private let stickLayer = CAShapeLayer()
	
	var stickStrokeWidth: CGFloat = 4.0 {
		didSet { update() }
	}
	
	var thumbRadius: CGFloat = 10 {
		didSet { update() }
	}
	
	// 0.0 positions thumb at the start of stick and 1.0 positions it at the end
	var thumbPosition: Float = 0.0 {
		didSet{ update() }
	}
	
	// Separate the color components of thumb, anticipating future extension
	var thumbStrokeColor: UIColor {
		get { return UIColor(CGColor: thumbLayer.strokeColor!) }
		set(thumbStrokeColor) {
			thumbLayer.strokeColor = thumbStrokeColor.CGColor
		}
	}
	
	var thumbFillColor: UIColor {
		get { return UIColor(CGColor: thumbLayer.fillColor!) }
		set(thumbFillColor) {
			thumbLayer.fillColor = thumbFillColor.CGColor
		}
	}
	
	var stickColor: UIColor {
		get { return UIColor(CGColor: stickLayer.strokeColor!) }
		set(stickColor) {
			stickLayer.strokeColor = stickColor.CGColor
		}
	}
	
	var stickLength: CGFloat {
		return stickLayer.bounds.width - (2 * thumbRadius)
	}
	
	
	
	// MARK: Methods
	
	// MARK: Initializers
	init() {}
	
	// MARK: Custom methods
	func update(bounds: CGRect) {
		thumbLayer.bounds = CGRectMake(-thumbRadius, -thumbRadius, 2*thumbRadius, 2*thumbRadius)
		stickLayer.bounds = bounds
		stickLayer.position = CGPoint(x: bounds.width/2.0, y: bounds.height/2)
		thumbLayer.position = CGPoint(x: -thumbRadius, y: bounds.height/2)
		update()
	}
	
	private func drawStick() {
		let path = UIBezierPath()
		path.moveToPoint(CGPoint(x: thumbRadius, y: stickLayer.bounds.height/2.0))
		path.addLineToPoint(CGPoint(x: stickLayer.bounds.width - thumbRadius, y: stickLayer.bounds.height/2.0))
		stickLayer.path = path.CGPath
	}
	
	private func drawThumb() {
		thumbLayer.path = UIBezierPath(
			arcCenter: CGPointZero,
			radius: thumbRadius,
			startAngle: 0.0,
			endAngle: 2*CGFloat(M_PI),
			clockwise: true).CGPath
	}
	
	private func update() {
		stickLayer.lineWidth = stickStrokeWidth
		stickLayer.lineCap = kCALineCapRound
		
		drawStick()
		drawThumb()
		positionThumb()
	}
	
	private func positionThumb() {
		thumbLayer.position.x = (CGFloat(thumbPosition) * stickLength) + (thumbRadius)
	}
	
}


