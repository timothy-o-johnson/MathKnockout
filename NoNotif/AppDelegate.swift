//
//  AppDelegate.swift
//  NoNotif
//
//  Created by Tim Johnson on 09/12/2016.
//  Copyright © 2016 Tim Johnson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let engine = GameEngine.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Fabric/Crashlytics removed; initialize engine or UI here if needed

//        engine.resetGameToBeKOedAllButOne()
//        engine.punches = [
//            Punch(num: 1, punchValue: 2, selected: false),
//            Punch(num: 2, punchValue: 4, selected: false),
//            Punch(num: 3, punchValue: 6, selected: false),
//            Punch(num: 4, punchValue: 8, selected: false)
//        ]

        return true
    }
}
