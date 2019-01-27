//
//  Helper.swift
//  HealthAI
//
//  Created by Feng Guo on 11/30/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import Foundation


class Helper{
    
    static func setupDateFormatter(format:String,date:Date)->String{
        
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "CST")! as TimeZone
        //let date = dateFormatter.string(from: Date())
        return dateFormatter.string(from: date)
    }
    
}
