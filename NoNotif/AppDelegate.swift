//
//  AppDelegate.swift
//  NoNotif
//
//  Created by John Grönlund on 09/12/2016.
//  Copyright © 2016 John Groenlund. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let engine = GameEngine.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
//        print(#function)
        
        UserDefaults.standard.set(NSArray(array: [1,2,3]), forKey: "nsArray-Int")
        UserDefaults.standard.set(NSArray(array: ["1","2","3"]), forKey: "nsArray-Str")
        UserDefaults.standard.set(NSArray(array: ["1",2,"3"]), forKey: "nsArray-Mix")
        
//        let engine = GameEngine.shared
        
        engine.punches = [
            Punch(num: 1, punchValue: 2, selected: false),
            Punch(num: 2, punchValue: 4, selected: false),
            Punch(num: 3, punchValue: 6, selected: false),
            Punch(num: 4, punchValue: 8, selected: false)
        ]
        
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainSB.instantiateViewController(withIdentifier: "WhichOneVC")
        let navCon = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = navCon
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print(#function)
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

