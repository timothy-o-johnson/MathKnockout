//
//  InterfaceController.swift
//  NoNotif WatchKit Extension
//
//  Created by John Grönlund on 09/12/2016.
//  Copyright © 2016 John Groenlund. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        print(#function)
        super.awake(withContext: context)
    
//         Configure interface objects here.
    }

    override func willActivate() {
        print(#function)
//         This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        print(#function)
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
