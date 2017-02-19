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
//        UserDefaults.standard.set(NSArray(array: [1,2,3]), forKey: "nsArray-Int")
//        UserDefaults.standard.set(NSArray(array: ["1","2","3"]), forKey: "nsArray-Str")
//        UserDefaults.standard.set(NSArray(array: ["1",2,"3"]), forKey: "nsArray-Mix")
        
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
}

