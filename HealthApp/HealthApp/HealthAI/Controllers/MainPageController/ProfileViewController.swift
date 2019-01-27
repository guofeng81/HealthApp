//
//  ProfileViewController.swift
//  HealthAI
//
//  Created by Feng Guo on 10/29/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseStorage
import ChameleonFramework

class ProfileViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate{
    
    let gender = ["Male","Female"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderPickerView.isHidden = true
        numberOfvalues[0] = gender[row]
        setGenderValue(value: gender[row])
        bioTableView.reloadData()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var bioTableView: UITableView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var genderPickerView: UIPickerView!
    
    var databaseRef : DatabaseReference!
    var storageRef : StorageReference!
    var LoginUser  = Auth.auth().currentUser!
    var imagePicker = UIImagePickerController()
    
    let bioList = ["Gender","Height","Weight","Glucose","Blood Pressure"]
    
    let unitList = ["","cm","kg","mm/dl","mmHg"]
    
    let bio = ["gender","height","weight","glucose","bloodpressure"]
    
    var numberOfvalues = ["","","","",""]
    
    let cellHeight = 70
    let Offset = 10
    
    //MARK - Table View Set up
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bioCell", for: indexPath) as! BioCell
        
//        let bottomBorder = CAShapeLayer()
//        let bottomPath = UIBezierPath()
//        bottomPath.move(to: CGPoint(x: 10, y:  CGFloat(cellHeight * (indexPath.row + 1))))
//        bottomPath.addLine(to: CGPoint(x: bioTableView.frame.width-10, y: CGFloat(cellHeight * (indexPath.row + 1))))
//        bottomBorder.path = bottomPath.cgPath
//        bottomBorder.strokeColor = UIColor.gray.cgColor
//        bottomBorder.lineWidth = 1.0
//        //bottomBorder.fillColor = UIColor.gray.cgColor
//        bioTableView.layer.addSublayer(bottomBorder)
//        
        
        //cell.textLabel?.text = bioList[indexPath.row]
        
        cell.bioTitle.text = bioList[indexPath.row]
        cell.bioImage.image = UIImage(named:bio[indexPath.row])
        
        cell.unitLabel.text = unitList[indexPath.row]
        
        print("Values in the table view \(bio[indexPath.row])")
        
        print("Load database values!!!!")
        
        loadBioValues { (values) in
            
            self.numberOfvalues = values
            
            cell.valueLabel.text = self.numberOfvalues[indexPath.row]
        
            }
        
           return cell
        
        }
    
    typealias CompletionHandler = (_ newValue:[String]) -> Void
    
    func loadBioValues(completionHandler:@escaping CompletionHandler){
        
        var newValues = [String]()
        
        databaseRef.child("profile").child(LoginUser.uid).observeSingleEvent(of: .value, with:{ (snapshop) in
            
            let dictionary = snapshop.value as? NSDictionary
            
            for index in 0..<self.bio.count {
                let value = dictionary![self.bio[index]] as! String
                newValues.append(value)
            }
            completionHandler(newValues)
            
        })
    }
    
    //MARK - Build the edit method for the UITableView
     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //let value = numberOfvalues[indexPath.row]
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            
            if indexPath.row == 0 {
                //implement the UIPickerView
                self.genderPickerView.isHidden = false
                
            }else{
                self.updateAction(indexPath: indexPath)
            }
        }
        
        editAction.backgroundColor = UIColor.blue
        return [editAction]
        
    }
    
    //Set all the values to the database.
    func setBioValues(values: [String]){
        for index in 0..<bio.count {
            databaseRef.child("profile").child(LoginUser.uid).updateChildValues([bio[index]:values[index]])
        }
    }
    
    // Set Bio Value in the screen, no the database.
    func setBioValue(value: String, indexPath: IndexPath){
        databaseRef.child("profile").child(LoginUser.uid).updateChildValues([bio[indexPath.row]:value])
    }
    func setGenderValue(value: String){
        databaseRef.child("profile").child(LoginUser.uid).updateChildValues([bio[0]:value])
    }
    
    private func updateAction(indexPath: IndexPath){
        
        let alert = UIAlertController(title: "Update", message: "Update your Bio", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            guard let textField = alert.textFields?.first else{
                return
            }
            if let textToEdit = textField.text {
                if textToEdit.count == 0 {
                    return
                }else{
                    //let the label to be the textToEdit
                    self.numberOfvalues[indexPath.row] = textToEdit
                    print(self.numberOfvalues)
                    self.setBioValue(value: textToEdit, indexPath: indexPath)
                    //self.setBioValues(values: self.numberOfvalues)
                    self.bioTableView.reloadRows(at: [indexPath], with: .automatic)
                }
                
            }else{
                return
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField()
        guard let textField = alert.textFields?.first else{
            return
        }
        
        textField.placeholder = "Update your Personal Information"
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert,animated: true)
        
    }
    
    //MARK - Set up the Profile UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getReferences()
        setProfilePicture(imageView: profileImageView)
        
        DatabaseHelper.loadDatabaseImage(databaseRef: databaseRef,user: LoginUser, imageView: profileImageView,referenceName: "photo")
        DatabaseHelper.setDatabaseUsername(databaseRef: databaseRef, user: LoginUser, label: usernameLabel)
        
        setImageViewTap()
        setGridentBackgroundColor()
        
        //self.bioTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        bioTableView.layer.masksToBounds = true
        bioTableView.layer.borderColor = UIColor( red: 153/255, green: 153/255, blue:0/255, alpha: 1.0 ).cgColor
        bioTableView.layer.borderWidth = 2.0
        
        bioTableView.layer.borderColor = UIColor.gray.cgColor
        bioTableView.layer.borderWidth = 1.0
       
        genderPickerView.isHidden = true
       //loadBioVlaues()
        
    }
    
    func setImageViewTap(){
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //set gradient color using chamleonframework
    
    func setGridentBackgroundColor(){
        backgroundView.backgroundColor = UIColor.init(
            gradientStyle: UIGradientStyle.radial,
            withFrame: backgroundView.frame,
            andColors: [ UIColor.flatBlue, UIColor.flatGreen,UIColor.flatLime]
        )
    }
    
    @objc func imageTapped()
    {
        
        let myActionSheet = UIAlertController(title: "Profile Picture", message: "Select the photo you want to change.", preferredStyle: .actionSheet)
        
//        let viewPicture = UIAlertAction(title: "View Picture", style: .default) { (action) in
//
//            let newImageView = UIImageView(image: self.profileImageView.image)
//
//            newImageView.frame = self.view.frame
//
//            newImageView.backgroundColor = UIColor.white
//            newImageView.contentMode = .scaleAspectFit
//            newImageView.isUserInteractionEnabled = true
//
//            let tap = UIGestureRecognizer(target: self, action: #selector(self.dismissFullScreenImage(sender:)))
//            newImageView.isUserInteractionEnabled = true
//            newImageView.addGestureRecognizer(tap)
//
//            self.view.addSubview(newImageView)
//
//        }
//
        let photoGallery = UIAlertAction(title: "Photos", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
                
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
                
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }
        }
        
        //myActionSheet.addAction(viewPicture)
        myActionSheet.addAction(photoGallery)
        myActionSheet.addAction(camera)
        myActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(myActionSheet, animated: true, completion: nil)
        
    }
    
    func getReferences(){
        databaseRef = Database.database().reference()
        storageRef = Storage.storage().reference()
    }
    
    internal func setProfilePicture(imageView: UIImageView){
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
    }
    

    @IBAction func saveProfileBtn(_ sender: UIButton) {
        
        //TODO - push all data which save in the screen to the database
        //setBioValues(values: numberOfvalues)
        self.dismiss(animated: true, completion: nil)
        
    }

    //MARK -  Pick the image from the photo library
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        setProfilePicture(imageView: self.profileImageView)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = image
        }
        
        
        DatabaseHelper.savePictureToStorage(storageRef: storageRef, databaseRef: databaseRef, user: LoginUser, imageView: profileImageView, imageName: "profile_image",referenceImageName: "photo")
        
        
        //savePictureToStorage(imageView: profileImageView)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
        
        self.dismiss(animated: true, completion: nil)
    }
    
//    func savePictureToStorage(imageView: UIImageView){
//
//        if let imageData: Data = imageView.image!.pngData() {
//
//            let profilePicReference = storageRef.child("user_profile/\(LoginUser.uid)/profile_pic")
//
//            DispatchQueue.main.async {
//                profilePicReference.putData(imageData, metadata: nil) { (metadata, error) in
//                    if error == nil {
//                        print("Successfuly putting the data to the storage.")
//
//                        profilePicReference.downloadURL { (url, error) in
//                            if let downloadUrl = url {
//
//                                print("Download URL:",downloadUrl)
//                                self.databaseRef.child("profile").child(self.LoginUser.uid).updateChildValues(["photo":downloadUrl.absoluteString])
//
//                            }else {
//                                print("error downloading from the url!")
//                            }
//                        }
//
//                    }else {
//                        print("error putting the data into the storage.")
//                    }
//                }
//            }
//        }
//    }
    

}
