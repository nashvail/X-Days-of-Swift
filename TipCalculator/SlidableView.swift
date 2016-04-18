//
//  SlidableView.swift
//  TipCalculator
//
//  Created by Nash Vail on 18/04/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

class SlidableView: UIControl {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addValueLabel(frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func addValueLabel(frame: CGRect) {
		let valueLabel: UILabel = UILabel(frame: frame)
		valueLabel.text = "80"
		valueLabel.textAlignment = .Center
		valueLabel.textColor = UIColor.whiteColor()
		valueLabel.backgroundColor = UIColor.clearColor()
		valueLabel.font = UIFont(name: "Avenir Next", size: 24.0)
		
		self.addSubview(valueLabel)
		
	}
	
	
}
