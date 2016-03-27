//
//  ColoredSlider.swift
//  SingleMusicPlayer
//
//  Created by Nash Vail on 27/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

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
			_backingValue = newValue
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
		self._backingValue = minimumValue
	}
	
	// MARK: Custom Methods
	func drawSubLayers() {
		renderer.update(bounds)
		renderer.stickColor = color
		renderer.thumbFillColor = color
		renderer.thumbStrokeColor = color
		
		layer.addSublayer(renderer.stickLayer)
	}
	

}

private class ColoredSliderRenderer {
	
	// MARK: Properties
	
	private let thumbLayer = CAShapeLayer()
	private let stickLayer = CAShapeLayer()
	
	var stickStrokeWidth: CGFloat = 6.0 {
		didSet { update() }
	}
	
	var thumbRadius: CGFloat = 10.0 {
		didSet { update() }
	}
	
	// 0.0 positions thumb at the start of stick and 1.0 positions it at the end
	var thumbPosition: CGFloat = 0.0 {
		didSet{ update() }
	}
	
	var thumbStrokeColor: UIColor {
		get { return UIColor(CGColor: thumbLayer.strokeColor!) }
		set(thumbStrokeColor) {
			thumbLayer.strokeColor = thumbStrokeColor.CGColor
		}
	}
	
	var thumbFillColor: UIColor {
		get { return UIColor(CGColor: thumbLayer.fillColor!) }
		set(thumbFillColor) {
			thumbLayer.strokeColor = thumbFillColor.CGColor
		}
	}
	
	var stickColor: UIColor {
		get { return UIColor(CGColor: stickLayer.strokeColor!) }
		set(stickColor) {
			stickLayer.strokeColor = stickColor.CGColor
		}
	}
	
	
	
	// MARK: Methods
	
	// MARK: Initializers
	init() {
		thumbLayer.fillColor = UIColor.clearColor().CGColor
		stickLayer.fillColor = UIColor.clearColor().CGColor
	}
	
	// MARK: Custom methods
	
	func drawStick() {
		let path = UIBezierPath()
		path.moveToPoint(CGPoint(x: 0.0, y: stickLayer.bounds.height/2.0))
		path.addLineToPoint(CGPoint(x: stickLayer.bounds.width, y: stickLayer.bounds.height/2.0))
		stickLayer.path = path.CGPath
	}
	
	func update() {
		stickLayer.lineWidth = stickStrokeWidth
		stickLayer.lineCap = kCALineCapRound
		drawStick()
	}
	
	func update(bounds: CGRect) {
		stickLayer.bounds = bounds
		stickLayer.position = CGPoint(x: bounds.width/2.0, y: 0.0)
		update()
	}
	
	
}
