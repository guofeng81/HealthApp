//
//  CalendarViewController.swift
//  HealthAI
//
//  Created by Feng Guo on 11/16/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit
import RealmSwift

enum MyTheme {
    case light
    case dark
}

class CalendarViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    
    var workoutHistories : Results<WorkoutHistoryItem>?
    
    var strengthWorkoutHistories : Results<WorkoutHistoryItem>?
    var cardioWorkoutHistories : Results<WorkoutHistoryItem>?
    
    //var selectedWorkoutHistoryItem = WorkoutHistoryItem()
    
    var arrayOfStrengthWorkouts = [WorkoutHistoryItem]()
    var arrayOfCardioWorkouts = [WorkoutHistoryItem]()
    
    var firstDistance = 0
    
    //Divide Carido Workouts and Strength Workouts into two sections based on date
    
    var seletedDate : String = ""
    
    var arrayOfCardioAndStrength = [String]()
    
    func convertMeterToMile(distance:Double)->Double {
        return distance / 1000 * 0.62
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return workoutHistories?.count ?? 1
        return arrayOfCardioAndStrength.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //From CalendarView Swift file in supporting files
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView(notification:)), name: NSNotification.Name(rawValue: "refreshDate"), object: nil)
        
        //From CalendarDetailCardio
        //NotificationCenter.default.addObserver(self, selector: #selector(refreshCalendarTableView(notification:)), name: NSNotification.Name(rawValue: "refreshCalendarTableView"), object: nil)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! CalendarHistoryCell
        
        // make sure the cell is fetching the cardio workout
        
        if arrayOfCardioAndStrength.count > 0 {
            cell.historyCellTitle.text = arrayOfCardioAndStrength[indexPath.row]
            
            if arrayOfCardioAndStrength[indexPath.row] == "Total Cardio Distance" {
                let distance = calculateCardioWorkoutTotalDistance(cardioWorkoutArray: arrayOfCardioWorkouts)
                cell.distanceLabel.text = String(format:"%.2f",convertMeterToMile(distance: distance)) + " mi"
            }else{
                cell.distanceLabel.text = ""
            }
        }
        
        return cell
    }
    
    //    @objc func refreshCalendarTableView(notification: NSNotification){
    //         historyTableView.reloadData()
    //    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        print("View did appear")
    //
    //        let date = setupDateFormatter(format: "yyyy-MM-dd", date: Date())
    //        filterWorkoutArray(selectedDate: date)
    //        historyTableView.reloadData()
    //
    //    }
    
    @objc func refreshTableView(notification: NSNotification){
        
        //load the selected Date data
        selectedDate = CalenderView.dateSelected
        
        print("Selected Date Here:" , selectedDate!)
        
        print("Calendar View Date Here:" , CalenderView.dateSelected)
        
        arrayOfStrengthWorkouts = [WorkoutHistoryItem]()
        arrayOfCardioWorkouts = [WorkoutHistoryItem]()
        
        filterWorkoutArray(selectedDate: CalenderView.dateSelected)
        
        
        
//        arrayOfCardioAndStrength = [String]()
//
//        let strengthPredicate = NSPredicate(format: "currentDate==%@ AND type==%@", selectedDate!,"Strength")
//        let cardioPredicate = NSPredicate(format: "currentDate==%@ AND type==%@", selectedDate!,"Cardio")
//
//        strengthWorkoutHistories = realm.objects(WorkoutHistoryItem.self).filter(strengthPredicate)
//        cardioWorkoutHistories = realm.objects(WorkoutHistoryItem.self).filter(cardioPredicate)
//
//        if let strengthWorkouts = strengthWorkoutHistories {
//            if strengthWorkouts.count > 0{
//                arrayOfCardioAndStrength.append("Strength Workouts")
//                for strengthWorkout in strengthWorkouts {
//                    arrayOfStrengthWorkouts.append(strengthWorkout)
//                }
//            }
//        }
//
//        if let cardioWorkouts = cardioWorkoutHistories {
//            if cardioWorkouts.count > 0 {
//                arrayOfCardioAndStrength.append("Total Cardio Distance")
//                for cardioWorkout in cardioWorkouts {
//                    arrayOfCardioWorkouts.append(cardioWorkout)
//                }
//            }
//        }
        
        
        
        print("Reload array",arrayOfCardioAndStrength)
        
        historyTableView.reloadData()
    }
    
    func filterWorkoutArray(selectedDate:String){
        
        arrayOfCardioAndStrength = [String]()
        
        let strengthPredicate = NSPredicate(format: "currentDate==%@ AND type==%@", selectedDate,"Strength")
        let cardioPredicate = NSPredicate(format: "currentDate==%@ AND type==%@", selectedDate,"Cardio")
        
        strengthWorkoutHistories = realm.objects(WorkoutHistoryItem.self).filter(strengthPredicate)
        cardioWorkoutHistories = realm.objects(WorkoutHistoryItem.self).filter(cardioPredicate)
        
        if let strengthWorkouts = strengthWorkoutHistories {
            if strengthWorkouts.count > 0{
                arrayOfCardioAndStrength.append("Strength Workouts")
                for strengthWorkout in strengthWorkouts {
                    arrayOfStrengthWorkouts.append(strengthWorkout)
                }
            }
        }
        
        if let cardioWorkouts = cardioWorkoutHistories {
            if cardioWorkouts.count > 0 {
                arrayOfCardioAndStrength.append("Total Cardio Distance")
                for cardioWorkout in cardioWorkouts {
                    arrayOfCardioWorkouts.append(cardioWorkout)
                }
            }
        }
    }
    
    func calculateCardioWorkoutTotalDistance(cardioWorkoutArray:[WorkoutHistoryItem])->Double{
        
        var distance:Double = 0
        
        for cardioWorkout in cardioWorkoutArray {
            distance += cardioWorkout.totalDistance
        }
        
        return distance
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arrayOfCardioAndStrength[indexPath.row] == "Strength Workouts" {
            performSegue(withIdentifier: "goToStrengthDetail", sender: self)
        }else if arrayOfCardioAndStrength[indexPath.row] == "Total Cardio Distance" {
            performSegue(withIdentifier: "goToCardioDetail", sender: self)
        }
        
        //selectedWorkoutHistoryItem = workoutHistories![indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //performSegue(withIdentifier: "goToHistoryDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Activity"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh(notification:)), name: NSNotification.Name(rawValue: "refreshSDate"), object: nil)
        
        let date = Helper.setupDateFormatter(format: "yyyy-MM-dd", date: Date())
        
        //pass the selectedDate to the CalendarDetail TableViewController
        if segue.identifier == "goToStrengthDetail" {
            let seg = segue.destination as! CalendarStrengthDetailTableViewController
            //let seg = segue.destination as! CalendarDetailStrengthTableViewController
            if selectedDate == nil {
                seg.strengthSelectedDate = date
            }else{
                seg.strengthSelectedDate = self.selectedDate!
            }
            
        }else if segue.identifier == "goToCardioDetail" {
            
            let seg = segue.destination as! CalendarDetailCardioTableViewController
            if selectedDate == nil {
                seg.cardioSelectedDate = date
            }else{
                seg.cardioSelectedDate = self.selectedDate!
            }
            //seg.cardioSelectedDate = self.selectedDate!
            
        }
    }
    
    @objc func refresh(notification: NSNotification){
        selectedDate = CalenderView.dateSelected
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //first time load the realm
    
    func loadWorkoutHistoryData(){
        
        let date = Helper.setupDateFormatter(format: "yyyy-MM-dd", date: Date())
        
        //arrayOfCardioAndStrength = [String]()
        
        print(date)
        
        filterWorkoutArray(selectedDate: date)
        
        print(arrayOfCardioAndStrength)
        
        historyTableView.reloadData()
    }
    
    
    //     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    //            self.historyTableView.reloadData()
    //        }
    //    }
    
    
    @IBOutlet var historyTableView: UITableView!
    
    var theme = MyTheme.dark
    
    var selectedDate:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWorkoutHistoryData()
        
        self.title = "My Calendar"
        self.navigationController?.navigationBar.isTranslucent=false
        self.view.backgroundColor=Style.bgColor
        view.addSubview(calenderView)
        
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive=true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive=true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive=true
        calenderView.heightAnchor.constraint(equalToConstant: 250).isActive=true
        
        let rightBarBtn = UIBarButtonItem(title: "Light", style: .plain, target: self, action: #selector(rightBarBtnAction))
        self.navigationItem.rightBarButtonItem = rightBarBtn
        let leftBarBtn = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(leftBarBtnAction))
        self.navigationItem.leftBarButtonItem = leftBarBtn
        
    }
    
    @objc func leftBarBtnAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    @objc func rightBarBtnAction(sender: UIBarButtonItem) {
        if theme == .dark {
            sender.title = "Dark"
            theme = .light
            Style.themeLight()
        } else {
            sender.title = "Light"
            theme = .dark
            Style.themeDark()
        }
        self.view.backgroundColor=Style.bgColor
        calenderView.changeTheme()
    }
    
    let calenderView: CalenderView = {
        let v=CalenderView(theme: MyTheme.dark)
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
}
