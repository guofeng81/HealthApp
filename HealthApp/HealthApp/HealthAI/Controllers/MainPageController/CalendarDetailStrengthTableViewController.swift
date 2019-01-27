//
//  CalendarDetailStrengthTableViewController.swift
//  HealthAI
//
//  Created by Feng Guo on 11/22/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit
import RealmSwift

class CalendarDetailStrengthTableViewController: UITableViewController {

//     let realm = try! Realm()
//
//    //var arrayOfStrengthWorkouts = [WorkoutHistoryItem]()
//
//    var strengthSelectedDate = ""
//
//    var strengthWorkoutHistories : Results<WorkoutHistoryItem>?
//
//    func loadStrengthWorkoutHistoryData(){
//
//        let strengthPredicate = NSPredicate(format: "currentDate==%@ AND type==%@", strengthSelectedDate,"Strength")
//        strengthWorkoutHistories = realm.objects(WorkoutHistoryItem.self).filter(strengthPredicate)
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadStrengthWorkoutHistoryData()
//
//        print("Strength Selected Date: ", strengthSelectedDate)
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return strengthWorkoutHistories?.count ?? 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "strengthCell", for: indexPath)
//
//        if let strengthWorkouts = strengthWorkoutHistories {
//            cell.textLabel!.text = strengthWorkouts[indexPath.row].title
//        }
//
//        return cell
//    }
    
}
