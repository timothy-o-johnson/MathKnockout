//
//  SplashScreenInterfaceController.swift
//  Math Knockout
//
//  Created by Tim Johnson on 11/30/15.
//  Copyright © 2015 Tim Johnson. All rights reserved.
//

import WatchKit
import Foundation


class SplashScreenInterfaceController: WKInterfaceController {

//    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any?
//    {
//        print(#function)
//        print(segueIdentifier)
//        return "context from SplashScreenIC"
//    }
    
//    override func awake(withContext context: Any?) {
//        print(#function)
//        super.awake(withContext: context)
//        print(context)
        // Configure interface objects here.
//    }

    override func willActivate() {
        
//        print(#function)
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        print("\n\nCurrent Interface: Splash Screen")
        
    }

//    override func didDeactivate() {
//        print(#function)
        // This method is called when watch view controller is no longer visible
//        super.didDeactivate()
//    }

//    @IBAction func letsPlay() {
//        print(#function)
//        self.presentController(withName: "chooseNumbersController", context: nil)
//    }
}
