//
//  MenuTableCell.swift
//  Time Table
//
//  Created by Nash Vail on 07/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

class MenuTableCell: UITableViewCell {

	@IBOutlet var label_menuItem: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		self.selectionStyle = .None
		self.backgroundColor = UIColor.clearColor()
	}

	override func setSelected(selected: Bool, animated: Bool) {
			super.setSelected(selected, animated: animated)

			// Configure the view for the selected state
	}

	override func setHighlighted(highlighted: Bool, animated: Bool) {
		if highlighted {
			self.label_menuItem.textColor = UIColor.greenColor()
		} else {
			self.label_menuItem.textColor = UIColor.whiteColor()
		}
	}

}
