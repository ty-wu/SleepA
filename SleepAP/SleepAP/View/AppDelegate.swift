//
//  AppDelegate.swift
//  SleepAP
//
//  Created by Wu, Tianyuan on 10/16/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Parse
import Bolts
import UserNotifications

//let kRootViewControllerKey = "rootViewKey"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // configuration for back4app backend flow
        let configuration = ParseClientConfiguration {
            $0.applicationId = "2cswjZuSxFiTPkXpE6g2ONBTfSlctCYZkEFbW1Ou"
            $0.clientKey = "ZKRSrROOYbfKc9l2CKyUdZ6GPoZvQoDwuijVitMD"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
        
        // show the main storyboard depending on the status of user
        if (self.window == nil) {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        let currentUser = PFUser.current()
        let isUserLoggedIn = currentUser != nil ? true : false
        if isUserLoggedIn {
            if (self.window?.rootViewController == nil) {
                self.window?.rootViewController = AppStoryboard.Main.instance
                    .instantiateViewController(withIdentifier: "tabBarViewController")
            }
        } else {
            self.window?.rootViewController = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: "loginViewController")
        }
        self.window?.makeKeyAndVisible()

        // set up notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(granted, error) in })
        
        //Update when Monday
        //weeklyUpdate()
        return true
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
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
//    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
//        return true
//    }
//
//    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
//        return true
//    }
//
//    // Encode app delegate level state restoration data
//    func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
//        if var topController = UIApplication.shared.keyWindow?.rootViewController {
//            while let presentedViewController = topController.presentedViewController {
//                topController = presentedViewController
//            }
//            coder.encode(topController, forKey: "rootViewKey")
//        }
//    }
//
//    // Decode app delegate level state restoration data
//    func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = coder.decodeObject(forKey: "rootViewKey") as? UIViewController
//    }

    // MARK: - helpers
    enum AppStoryboard : String {
        case Login, Main, Sleep, Record, Summary, Statistics, Reminder
        var instance : UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
        }
    }
}

