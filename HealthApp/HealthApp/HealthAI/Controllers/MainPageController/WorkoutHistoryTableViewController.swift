//
//  WorkoutHistoryTableViewController.swift
//  HealthAI
//
//  Created by Feng Guo on 11/5/18.
//  Copyright © 2018 Feng Guo. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class WorkoutHistoryTableViewController: UITableViewController {
    
//    let realm = try! Realm()
//
//    var workoutHistories : Results<WorkoutHistoryItem>?
//
//    var selectedWorkoutHistoryItem = WorkoutHistoryItem()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadWorkoutHistoryData()
//
//    }
//
//    func loadWorkoutHistoryData(){
//        workoutHistories = realm.objects(WorkoutHistoryItem.self)
//        tableView.reloadData()
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return workoutHistories?.count ?? 1
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        //cell.delegate = self
//
//        if let workout = workoutHistories?[indexPath.row]{
//            cell.textLabel?.text = workout.title
//        }else{
//            cell.textLabel?.text = "No Workout Item added"
//        }
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        selectedWorkoutHistoryItem = workoutHistories![indexPath.row]
//
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        performSegue(withIdentifier: "goToHistoryDetail", sender: self)
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToHistoryDetail" {
//            let seg = segue.destination as! HistoryDetailTableViewController
//            seg.selectedWorkoutHistoryItem = self.selectedWorkoutHistoryItem
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//            if let workoutHistroyForDeletion = self.workoutHistories?[indexPath.row]{
//                do{
//                    try self.realm.write{
//                        self.realm.delete(workoutHistroyForDeletion)
//                    }
//                }catch{
//                    print("Error delelting the the item using realm")
//                }
//            }
//
//            self.tableView.reloadData()
//        }
//    }
    
}

//extension WorkoutHistoryTableViewController : SwipeTableViewCellDelegate {
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//
//            if let workoutHistroyForDeletion = self.workoutHistories?[indexPath.row]{
//                do{
//                    try self.realm.write{
//                        self.realm.delete(workoutHistroyForDeletion)
//                    }
//                }catch{
//                    print("Error delelting the the item using realm")
//                }
//            }
//
//        }
//
//        // customize the action appearance
//
//        //deleteAction.image = UIImage(named: "delete_icon")
//
//        return [deleteAction]
//    }

//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }

//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }
//
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle ==  .delete{
//            // self.data.remove(at: indexPath.row)
//            //self.tableView.reloadData()
//            do{
//                try self.realm.write{
//                    self.realm.delete(self.workoutHistories![indexPath.row])
//                }
//            }catch{
//                print("Error delelting the the item using realm")
//            }
//            self.tableView.reloadData()
//        }
//    }
    
    
    
//}
