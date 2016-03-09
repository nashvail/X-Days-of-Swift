//
//  ColorData.swift
//  Time Table
//
//  Created by Nash Vail on 08/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import Foundation
import UIKit

// Color for the default green color in the app
let defaultColor = UIColor(red: 66/255.0, green: 73/255.0, blue: 59/255.0, alpha: 1)

// Colors for cells that are visible in the Time Table TableView
let cellColors = ["#C3D8B9", "#BCD2B0", "#AEC4A4", "#9EB394", "#7BA07D", "#6F8A67", "#505D41", "#43483B"]

// The current subject being taught is colored in this color
let currentSubjectColor = UIColor(red: 71/255.0, green: 124/255.0, blue: 215/255.0, alpha: 1)

// Converts HEX String to UIColor
func colorWithHexString (hex:String) -> UIColor {
	var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
	
	if (cString.hasPrefix("#")) {
		cString = (cString as NSString).substringFromIndex(1)
	}
	
	if (cString.characters.count != 6) {
		return UIColor.grayColor()
	}
	
	let rString = (cString as NSString).substringToIndex(2)
	let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
	let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
	
	var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
	NSScanner(string: rString).scanHexInt(&r)
	NSScanner(string: gString).scanHexInt(&g)
	NSScanner(string: bString).scanHexInt(&b)
	
	
	return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}
