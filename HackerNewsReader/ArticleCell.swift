//
//  ArticleCell.swift
//  HackerNewsReader
//
//  Created by Nash Vail on 08/05/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {


	// MARK: IBOutlets
	
	@IBOutlet var label_articleTitle: UILabel!
	@IBOutlet var label_articleSource: UILabel!
	@IBOutlet var label_articleVotes: UILabel!
	

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		// Configure the view of the selected row
	}

}
