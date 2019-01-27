//
//  CalendarHistoryCell.swift
//  HealthAI
//
//  Created by Feng Guo on 11/21/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit

class CalendarHistoryCell: UITableViewCell {

    
    @IBOutlet var contentViewCell: UIView!
    
    @IBOutlet var historyCellTitle: UILabel!
    
    @IBOutlet var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        contentViewCell.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
