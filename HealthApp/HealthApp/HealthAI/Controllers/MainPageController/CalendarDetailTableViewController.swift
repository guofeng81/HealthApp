//
//  CalendarDetailTableViewController.swift
//  HealthAI
//
//  Created by Feng Guo on 11/18/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit
import RealmSwift

class CalendarDetailTableViewController: UITableViewController {
    
//    var selectedWorkoutHistoryItem = WorkoutHistoryItem()
//
//    var selectedDate:String?
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//         //return workoutHistories?.count ?? 1
//        return 1
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell", for: indexPath)
//
//        //cell.delegate = self
//
////        if let workout = workoutHistories?[indexPath.row]{
////            cell.textLabel?.text = workout.title
////        }else{
////            cell.textLabel?.text = "No Workout Item added"
////        }
//
//        //based on the current date
//
//        return cell
//    }
//
//
//   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
////        selectedWorkoutHistoryItem = workoutHistories![indexPath.row]
////
////        print("After date formatter",dateFormatter(currentDate: selectedWorkoutHistoryItem.currentDate!))
////
////
////        print("SelectworkoutHistroy Item:", selectedWorkoutHistoryItem.currentDate)
//
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        performSegue(withIdentifier: "goToDetail", sender: self)
//    }
//
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToDetail" {
//            let seg = segue.destination as! CalendarDetailTableViewController
//            seg.selectedWorkoutHistoryItem = self.selectedWorkoutHistoryItem
//        }
//    }
//

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
