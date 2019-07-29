//
//  BoardInterfaceController.swift
//  Math Knockout
//
//  Created by Tim Johnson on 11/30/15.
//  Copyright © 2015 Tim Johnson. All rights reserved.
//

import WatchKit
import Foundation

class BoardInterfaceController : WKInterfaceController
{
    let engine = GameEngine.shared
    
    override func willActivate()
    {
        super.willActivate()
        
        for tile in engine.tiles
        {
            let button = whichButton(tile.number)
            button.setTitle(tile.display)
            button.setEnabled(!tile.KOed)
        }
        
        if engine.gameIsWon
        {
            // func updateGamesWon()
            WKInterfaceController.reloadRootPageControllers(withNames: ["WonIC"], contexts: nil, orientation: .horizontal, pageIndex: 0)
        }
    }
    
    @IBOutlet var one: WKInterfaceButton!
    @IBOutlet var two: WKInterfaceButton!
    @IBOutlet var three: WKInterfaceButton!
    @IBOutlet var four: WKInterfaceButton!
    @IBOutlet var five: WKInterfaceButton!
    
    @IBOutlet var six: WKInterfaceButton!
    @IBOutlet var seven: WKInterfaceButton!
    @IBOutlet var eight: WKInterfaceButton!
    @IBOutlet var nine: WKInterfaceButton!
    @IBOutlet var ten: WKInterfaceButton!
    
    @IBOutlet var eleven: WKInterfaceButton!
    @IBOutlet var twelve: WKInterfaceButton!
    @IBOutlet var thirteen: WKInterfaceButton!
    @IBOutlet var fourteen: WKInterfaceButton!
    @IBOutlet var fifteen: WKInterfaceButton!
    
    @IBOutlet var sixteen: WKInterfaceButton!
    @IBOutlet var seventeen: WKInterfaceButton!
    @IBOutlet var eighteen: WKInterfaceButton!
    @IBOutlet var nineteen: WKInterfaceButton!
    @IBOutlet var twenty: WKInterfaceButton!
    
    @IBOutlet var twentyOne: WKInterfaceButton!
    @IBOutlet var twentyTwo: WKInterfaceButton!
    @IBOutlet var twentyThree: WKInterfaceButton!
    @IBOutlet var twentyFour: WKInterfaceButton!
    @IBOutlet var twentyFive: WKInterfaceButton!
    
    
    @IBAction func oneTapped() {
        engine.knockOutTarget = 1
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func twoTapped() {
        engine.knockOutTarget = 2
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func threeTapped() {
        engine.knockOutTarget = 3
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func fourTapped() {
        engine.knockOutTarget = 4
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
   
    @IBAction func fiveTapped() {
        engine.knockOutTarget = 5
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func sixTapped() {
        engine.knockOutTarget = 6
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func sevenTapped() {
        engine.knockOutTarget = 7
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func eightTapped() {
        engine.knockOutTarget = 8
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func nineTapped() {
        engine.knockOutTarget = 9
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func tenTapped() {
        engine.knockOutTarget = 10
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }

    @IBAction func elevenTapped() {
        engine.knockOutTarget = 11
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func twelveTapped() {
        engine.knockOutTarget = 12
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func thirteenTapped() {
        engine.knockOutTarget = 13
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func fourteenTapped() {
        engine.knockOutTarget = 14
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func fifteenTapped() {
        engine.knockOutTarget = 15
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func sixteenTapped() {
        engine.knockOutTarget = 16
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func seventeenTapped() {
        engine.knockOutTarget = 17
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func eighteenTapped() {
        engine.knockOutTarget = 18
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func nineteenTapped() {
        engine.knockOutTarget = 19
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func twentyTapped() {
        engine.knockOutTarget = 20
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func twentyOneTapped() {
        engine.knockOutTarget = 21
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func twentyTwoTapped() {
        engine.knockOutTarget = 22
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func twentyThreeTapped() {
        engine.knockOutTarget = 23
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func twentyFourTapped() {
        engine.knockOutTarget = 24
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    @IBAction func twentyFiveTapped() {
        engine.knockOutTarget = 25
        print("Button Tapped: \(engine.knockOutTarget)")
        sendTargetToRing()
    }
    
    func sendTargetToRing()
    {
        print("Moving to howToKnockOut controller")
        pushController(withName: "howToKnockOut", context: [])
    }
    
    
    func whichButton(_ number : Int) -> WKInterfaceButton
    {
        switch number
        {
            case  1 : return one
            case  2 : return two
            case  3 : return three
            case  4 : return four
            case  5 : return five
            case  6 : return six
            case  7 : return seven
            case  8 : return eight
            case  9 : return nine
            case 10 : return ten
            case 11 : return eleven
            case 12 : return twelve
            case 13 : return thirteen
            case 14 : return fourteen
            case 15 : return fifteen
            case 16 : return sixteen
            case 17 : return seventeen
            case 18 : return eighteen
            case 19 : return nineteen
            case 20 : return twenty
            case 21 : return twentyOne
            case 22 : return twentyTwo
            case 23 : return twentyThree
            case 24 : return twentyFour
            case 25 : return twentyFive
            default : print("No button was picked."); return one
        }
    }
    
    
    @IBAction func startOver()
    {
        engine.resetGame()

        WKInterfaceController.reloadRootPageControllers(withNames: ["SplashScreenController"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
    
}
