//
//  WorkoutCell.swift
//  HealthAI
//
//  Created by Feng Guo on 11/20/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {

    @IBOutlet var workoutTitle: UILabel!
    @IBOutlet var workoutImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
