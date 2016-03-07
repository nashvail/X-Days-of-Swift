//
//  TimeTableViewCell.swift
//  Time Table
//
//  Created by Nash Vail on 06/03/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

extension UILabel {
	func addCharactersSpacing(spacing:CGFloat, text:String) {
		let attributedString = NSMutableAttributedString(string: text)
		attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, text.characters.count))
		self.attributedText = attributedString
	}
}

class TimeTableViewCell: UITableViewCell {

	@IBOutlet weak var label_time: UILabel!
	@IBOutlet weak var label_subjectName: UILabel!
	
	override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
		self.selectionStyle = UITableViewCellSelectionStyle.None
		
  }
	
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
