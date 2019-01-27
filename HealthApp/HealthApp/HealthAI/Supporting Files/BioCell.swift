//
//  BioTableViewCell.swift
//  HealthAI
//
//  Created by Feng Guo on 10/28/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit

class BioCell: UITableViewCell {

    
    @IBOutlet var unitLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var bioTitle: UILabel!
    @IBOutlet var bioImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
