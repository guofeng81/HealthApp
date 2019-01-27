//
//  VideoCell.swift
//  HealthAI
//
//  Created by Feng Guo on 11/30/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var videoCellImageView: UIImageView!
    @IBOutlet var videoCellView: UIView!
    @IBOutlet var videoTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
