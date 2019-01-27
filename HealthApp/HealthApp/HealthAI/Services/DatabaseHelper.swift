//
//  DatabaseHelper.swift
//  HealthAI
//
//  Created by Feng Guo on 10/25/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import Firebase

class DatabaseHelper {
    
    
    static func loadDatabaseImage(databaseRef: DatabaseReference!, user: User, imageView: UIImageView,referenceName:String){
        
        databaseRef.child("profile").child(user.uid).observeSingleEvent(of: .value, with:{ (snapshop) in
            let dictionary = snapshop.value as? NSDictionary
            
            //let username = dictionary?["username"] as? String ?? ""
            
            if let profileImageURL = dictionary?[referenceName] as? String {
                
                let url = URL(string: profileImageURL)
                
                URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    DispatchQueue.main.async {
                        //self.profileImageView.image = UIImage(data: data!)
                        imageView.image = UIImage(data: data!)
                    }
                    
                }).resume()
                
                //self.usernameLabel.text = username
                
            }
        }){
            (error) in
            print(error.localizedDescription)
            return
        }
        
    }
    
    static func setDatabaseUsername(databaseRef: DatabaseReference!, user: User, label: UILabel){
        
        databaseRef.child("profile").child(user.uid).observeSingleEvent(of: .value, with:{ (snapshop) in
            
            let dictionary = snapshop.value as? NSDictionary
            
            label.text = dictionary?["username"] as? String
        })
    }
    
    
    static func savePictureToStorage(storageRef: StorageReference!, databaseRef: DatabaseReference!, user: User,imageView: UIImageView, imageName: String,referenceImageName: String){
        
        if let imageData: Data = imageView.image!.pngData() {
            
            //Storage Reference:
            let profilePicReference = storageRef.child("user_profile/\(user.uid)/\(imageName)")
            
            print("Profile Picture Reference:",profilePicReference)
            
            DispatchQueue.main.async {
                profilePicReference.putData(imageData, metadata: nil) { (metadata, error) in
                    if error == nil {
                        print("Successfuly putting the data to the storage.")
                        
                        profilePicReference.downloadURL { (url, error) in
                            if let downloadUrl = url {
                                
                                print("Profile Picture Download URL: ",downloadUrl)
                                databaseRef.child("profile").child(user.uid).updateChildValues([referenceImageName:downloadUrl.absoluteString])
                                
                                
                            }else {
                                print("error downloading from the url!")
                            }
                        }
                        
                    }else {
                        print("error putting the data into the storage.")
                    }
                }
            }
        }
    }
    
}
