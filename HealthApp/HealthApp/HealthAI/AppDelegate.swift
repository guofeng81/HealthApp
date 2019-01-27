//
//  AppDelegate.swift
//  HealthAI
//
//  Created by Naresh Kumar on 02/10/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import SVProgressHUD
import RealmSwift
import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            return
        }
        
        SVProgressHUD.show()
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (auth, error) in
            if error != nil {
                print(error!)
            }else{
                //user signed in with google
                
                print("In the sign in the retrieveData called with google")
                
                AuthServices.createUserProfile()
                
                //TODO - pop to the Health Main Screen
                
                SVProgressHUD.dismiss()
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let myNewVC = mainStoryboard.instantiateViewController(withIdentifier: "HealthMain") as! HealthMainViewController
                let navController = UINavigationController(rootViewController: myNewVC)
                navController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.window?.rootViewController?.present(navController, animated: true, completion: nil)
            }
        }
        
        print("Google sign in outside the function.")
        
        
    }
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
         SVProgressHUD.dismiss()
        
         print(Realm.Configuration.defaultConfiguration.fileURL)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance()?.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
        GIDSignIn.sharedInstance().handle(url,
                                          sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                          annotation:options[UIApplication.OpenURLOptionsKey.annotation])
        
        return handled!
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        FBSDKLoginManager().logOut()
        GIDSignIn.sharedInstance().signOut()
    }


}

