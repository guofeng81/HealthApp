//
//  CardioSummaryCell.swift
//  HealthAI
//
//  Created by Feng Guo on 11/22/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit

class CardioSummaryCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var distanceLabel: UILabel!
    
    @IBOutlet var summaryView: UIView!
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var averageSpeedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        summaryView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
