//
//  ExtensionDelegate.swift
//  NoNotif WatchKit Extension
//
//  Created by John Grönlund on 09/12/2016.
//  Copyright © 2016 John Groenlund. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate
{
    let engine = GameEngine.shared
    
    func applicationDidFinishLaunching()
    {
        print("watch did finish launching")
        
        // engine.resetGameToBeKOedAllButOne()
    }
}
