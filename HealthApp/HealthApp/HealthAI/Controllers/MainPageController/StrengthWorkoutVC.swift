//
//  StrengthWorkoutVC.swift
//  HealthAI
//
//  Created by Feng Guo on 11/24/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit

class StrengthWorkoutVC: UIViewController {

    var workoutName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = workoutName
    }
    
    func customInit(workoutName: String) {
        self.workoutName = workoutName
    }

}
