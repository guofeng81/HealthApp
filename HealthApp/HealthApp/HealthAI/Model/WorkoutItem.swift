//
//  WorkoutItem.swift
//  HealthAI
//
//  Created by Feng Guo on 11/7/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import Foundation

class WorkoutItem {
    
    var type : String = ""
    var title: String = ""
    var content: String = ""
    var body:String = ""
    var hardness:String = ""
    var duration: String = ""
    var strength:String = ""
    var currentDate: Date?
    
    var subworkouts = [SubworkoutItem]()
}
