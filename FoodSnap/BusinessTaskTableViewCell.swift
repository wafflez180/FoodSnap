//
//  BusinessTaskTableViewCell.swift
//  FoodSnap
//
//  Created by Arthur De Araujo on 6/23/17.
//  Copyright © 2017 Arthur De Araujo. All rights reserved.
//

import UIKit

class BusinessTaskTableViewCell: UITableViewCell {
    
    @IBOutlet var goalLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var prizeLabel: UILabel!
    @IBOutlet var expirationLabel: UILabel!
    @IBOutlet var totalLikesLabel: UILabel!
    @IBOutlet var picsTakenLabel: UILabel!
    @IBOutlet var completedGoalsLabel: UILabel!
    
    @IBOutlet var numPostLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
