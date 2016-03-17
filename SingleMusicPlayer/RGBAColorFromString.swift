//
//  RGBAColorFromString.swift
//  SingleMusicPlayer
//
//  Created by Nash Vail on 17/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//	------------------------------------------------------------------
//
//	Exports implementaion of functions that make usage of UIColor simpler

import UIKit

/*
*	Function: RGB(red, green, blue)
* -------------------------------
* Given values of red, green, blue colors in float. Returns 
* equivalent UIColor.
*/
func RGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
	return RGBA(red, green: green, blue: blue, alpha: 255)
}

/*
*	Function: RGBA(red, green, blue)
* -------------------------------
* Given values of red, green, blue colors and the value of alpha in float. Returns
* equivalent UIColor.
*/
func RGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
	return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha/255)
}

extension UIColor {
	
	class func RGBAColorFromString(string: String?) -> UIColor? {
		
		if let string = string {
			
			var components = (string as NSString).componentsSeparatedByString(",") as [NSString]
			
			if components.count == 3 {
				components.append("1.0")
			}
			
			if components.count != 4 {
				return nil
			}
			
			let red = CGFloat(components[0].floatValue / 255)
			let green = CGFloat(components[1].floatValue / 255)
			let blue = CGFloat(components[2].floatValue / 255)
			let alpha = CGFloat(components[3].floatValue / 255)
			
			return UIColor(red: red, green: green, blue: blue, alpha: alpha)
		}
		
		return nil
	}
}
