//
//  WorkoutClockViewController.swift
//  HealthAI
//
//  Created by Feng Guo on 07/11/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit
import RealmSwift
import AVKit

protocol DataTransferDelegate:class {
    func userDidFinishedSubworkout(subworkoutItem:SubworkoutItem)
}

class WorkoutClockViewController: UIViewController {
    
    @IBOutlet var startBtn: UIButton!
    
    //time is only for the seconds
    var time:Int = 0
    var timer:Timer? = nil
   
    var delegate : DataTransferDelegate?
    
    var selectedSubworkoutItem = SubworkoutItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // print("Selected Subworkout",selectedSubworkoutItem.title)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(endWorkoutPressed(sender:)))
        //self.navigationItem.hidesBackButton = true
        
        setupButtons()
        
    }
    
    
    @objc func endWorkoutPressed(sender:AnyObject){
        print("End")
        
        self.saveWorkout()
        self.navigationController?.popViewController(animated: true)
        
//        let alert = UIAlertController(title: "End Workout", message: "Are you sure you want to end your workout?", preferredStyle: .alert)
//
//        // add the actions (buttons)
//        alert.addAction(UIAlertAction(title: "End Workout", style: .default, handler: { (action) in
//            self.saveWorkout()
//            self.navigationController?.popViewController(animated: true)
//        }))
//
//        alert.addAction(UIAlertAction(title: "Back to Workout", style: .cancel, handler: nil))
//
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
    }
    
    func setupButtons(){
        
        let normalGesture = UITapGestureRecognizer(target: self, action: #selector(normalTap(_:)))
        startBtn.addGestureRecognizer(normalGesture)
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector((longTap(_:))))
        startBtn.addGestureRecognizer(longGesture)
        
        startBtn.layer.cornerRadius = startBtn.frame.width / 2
        startBtn.clipsToBounds = true
        
        setupButtonImage(imageName: "play")

    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
//    @IBAction func endWorkoutBtn(_ sender: Any) {
//
//        let alert = UIAlertController(title: "End Workout", message: "Are you sure you want to end your workout?", preferredStyle: .alert)
//
//        // add the actions (buttons)
//        alert.addAction(UIAlertAction(title: "End & Save Workout", style: .default, handler: { (action) in
//            self.saveWorkout()
//            self.navigationController?.popViewController(animated: true)
//        }))
//
//        alert.addAction(UIAlertAction(title: "End Without Saving", style: .default, handler: { (action) in
//            self.navigationController?.popViewController(animated: true)
//        }))
//
//        alert.addAction(UIAlertAction(title: "Back to Workout", style: .cancel, handler: nil))
//
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
//
//    }

    //MARK - Perform Data Save!
    
    func saveWorkout(){
        
        // get the date time String from the date object
        
        selectedSubworkoutItem.time = time
        selectedSubworkoutItem.done = true
        
        //pass the selectedSubworkoutItem data back to the previous view controller
        
        delegate!.userDidFinishedSubworkout(subworkoutItem: selectedSubworkoutItem)

    }
    
    
    @objc func action(){
        time += 1
        let minutesPortion = String(format: "%02d", self.time / 60)
        let secondsPortion = String(format: "%02d", self.time % 60)
        timeLabel.text = "\(minutesPortion):\(secondsPortion)"
    }
    
    @objc func longTap(_ sender:UIGestureRecognizer){
        if time != 0 {
            time = 0
            let minutesPortion = String(format: "%02d", self.time / 60)
            let secondsPortion = String(format: "%02d", self.time % 60)
            timeLabel.text = "\(minutesPortion):\(secondsPortion)"
        }
    }
    
    @objc func normalTap(_ sender:UIGestureRecognizer) {
        if timer != nil {
            setupButtonImage(imageName: "play")
            timer!.invalidate()
            timer = nil
        }else{
            setupButtonImage(imageName: "pause")
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(WorkoutClockViewController.action),userInfo: nil, repeats: true)
            
        }
    }
    
    func setupButtonImage(imageName:String){
        
        let startBtnimage = UIImageView()
        startBtnimage.frame = startBtn.frame
        startBtnimage.contentMode = .scaleAspectFit
        startBtnimage.clipsToBounds = true
        startBtnimage.image = UIImage(named: imageName)
        startBtn.addSubview(startBtnimage)
        
    }
    
    //Play the workout tutorial video
    
    @IBAction func videoPlayBtn(_ sender: UIButton) {
        
        if let path = Bundle.main.path(forResource: selectedSubworkoutItem.videoName, ofType: "MOV"){
            
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer,animated: true,completion: {
                video.play()
                
            })
        }
    }
    
}
