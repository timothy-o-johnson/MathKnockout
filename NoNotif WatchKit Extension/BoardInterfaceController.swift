//
//  BoardInterfaceController.swift
//  Math Knockout
//
//  Created by Tim Johnson on 11/30/15.
//  Copyright © 2015 Tim Johnson. All rights reserved.
//

import WatchKit
import Foundation

//class Opponent : NSObject, NSCoding
//{
//    var knockedOut   = false
//    var attemptCount = 0
//    var operation    = ""
//    
//    required init?(coder aDecoder: NSCoder)
//    {
//        super.init()
//        
//        knockedOut   = aDecoder.decodeObject(forKey: "knockedOut")   as! Bool
//        attemptCount = aDecoder.decodeObject(forKey: "attemptCount") as! Int
//        operation    = aDecoder.decodeObject(forKey: "operation")    as! String
//    }
//    
//    func encode(with aCoder: NSCoder)
//    {
//        aCoder.encode(knockedOut,   forKey: "knockedOut")
//        aCoder.encode(attemptCount, forKey: "attemptCount")
//        aCoder.encode(operation,    forKey: "operation")
//    }
//}

class Tile
{
    let number : Int
    var KOed = "no"
    var operation = ""
    var attempts = 0
    var display = ""
    
    init(_ number: Int)
    {
        self.number = number
        
        if self.number < 10
        {
            self.display = " " + String(self.number)
        }
        else
        {
            self.display = String(self.number)
        }
    }
    
    func update_display()
    {
        if self.KOed == "no"
        {
            if self.number < 10
            {
                self.display = " " + String(self.number)
            }
            else
            {
                self.display = String(self.number)
            }
        }
        else
        {
            self.display = " X"
            self.KOed = "yes"
        }
    }
}



class BoardInterfaceController : WKInterfaceController
{
    let engine = GameEngine.shared
    
    // for sending to next interface
//    var knockOutTarget = 0
//    var targetKOstatus = "no"
    
    // for output screen
    var board = [Tile]()

    // for storing board info into NSUserDefaults
    var dictKOed = [String: String]()
    var dictAttempt = [String: Int]()
    var dictOperation = [String: String]()
    
//    var passThoughSelectedPunches : SelectedPunches!
    var passThoughContext : [String : Any]?
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any?
    {
        print(#function)
        print(segueIdentifier)
        
//        let context : [String : Any] = [
//            "selectedPunches" : passThoughSelectedPunches,
//            "knockOutTarget"  : knockOutTarget,
//            "targetKOstatus"  : targetKOstatus
//        ]
        
//        engine.knockOutTarget = knockOutTarget
        
//        passThoughContext!["knockOutTarget"] = knockOutTarget
//        passThoughContext["targetKOstatus"] = targetKOstatus
        
        return passThoughContext
//        return passThoughSelectedPunches
//        return "ChooseFourIC"
    }
    
    override func awake(withContext context: Any?) { // Configure interface objects here.
        print(#function)
        super.awake(withContext: context)
        
        passThoughContext = context as? [String : Any]
//        passThoughSelectedPunches = context as! SelectedPunches
        
        printCurrentInterface() // sends current interface name to console
        
        print("Context is \(context)")
        
        board = createBoard()
        
//        if context == nil{
//            board = createBoard()
        initializeDictionaries()
//        initializeBoardTargetAndTargetInfo()
//        } else {
//            board = createBoard()
//            refreshBoard()
//        }
        
        //printBoard(board)
//        for x in 1...25{
//            updateScreenButton(x)
//        }
        
//        printSelectedNumbers()
    }
    
    override func willActivate() {// This method is called when watch view controller is about to be visible to user
        print(#function)
        super.willActivate()
        
//        for (index, tile) in engine.tiles.enumerated()
        for tile in engine.tiles
        {
//            let buttonKVCName = "button" + String(tile.number)
            let button = whichButton(tile.number)
//            let button = value(forKey: buttonKVCName) as! WKInterfaceButton
            button.setTitle(tile.display)
//            setValue(tile.display, forKey: buttonKVCName)
//            button1.setTitle(<#T##title: String?##String?#>)
        }
        
//        refreshBoard()
        //printBoard(board)
//        for x in 1...25{
//            updateScreenButton(x)
//        }
        
        printSelectedNumbers()
    }
    
    override func didDeactivate() {
        print(#function)
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
//    @IBOutlet var button1  : WKInterfaceButton!
//    @IBOutlet var button2  : WKInterfaceButton!
//    @IBOutlet var button3  : WKInterfaceButton!
//    @IBOutlet var button4  : WKInterfaceButton!
//    @IBOutlet var button5  : WKInterfaceButton!
//    
//    @IBOutlet var button6  : WKInterfaceButton!
//    @IBOutlet var button7  : WKInterfaceButton!
//    @IBOutlet var button8  : WKInterfaceButton!
//    @IBOutlet var button9  : WKInterfaceButton!
//    @IBOutlet var button10 : WKInterfaceButton!
//    
//    @IBOutlet var button11 : WKInterfaceButton!
//    @IBOutlet var button12 : WKInterfaceButton!
//    @IBOutlet var button13 : WKInterfaceButton!
//    @IBOutlet var button14 : WKInterfaceButton!
//    @IBOutlet var button15 : WKInterfaceButton!
//    
//    @IBOutlet var button16 : WKInterfaceButton!
//    @IBOutlet var button17 : WKInterfaceButton!
//    @IBOutlet var button18 : WKInterfaceButton!
//    @IBOutlet var button19 : WKInterfaceButton!
//    @IBOutlet var button20 : WKInterfaceButton!
//    
//    @IBOutlet var button21 : WKInterfaceButton!
//    @IBOutlet var button22 : WKInterfaceButton!
//    @IBOutlet var button23 : WKInterfaceButton!
//    @IBOutlet var button24 : WKInterfaceButton!
//    @IBOutlet var button25 : WKInterfaceButton!
    
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
        print("\nFunction: sendTargetToRing()")
        //save knockOut Target
//        UserDefaults.standard.set(knockOutTarget,forKey:"knockOutTarget")
        
        
        //save board status
        saveBoardStatus()

        //NSUserDefaults.standardUserDefaults().setObject(board,forKey:"board")
        
        printNSUserDefaultsForKOAndAttemptAndOperation()
        
        print("Moving to howToKnockOut controller")
//        self.presentController(withName: "howToKnockOut", context: nil)
//        self.presentController(withName: "howToKnockOut", context: passThoughSelectedPunches)
//        pushController(withName: "howToKnockOut", context: passThoughSelectedPunches)
        
//        engine.knockOutTarget = knockOutTarget
//        passThoughContext!["knockOutTarget"] = knockOutTarget
        WKInterfaceController.reloadRootControllers(withNames: ["howToKnockOut"], contexts: [])
//        pushController(withName: "howToKnockOut", context: passThoughContext)
    }
    

    func createBoard() -> [Tile]
    {
        var temporaryBoard = [Tile]()
        let boardSize = 25
    
        for x in 0..<boardSize
        {
            let y = Tile(x+1)
            temporaryBoard.append(y)
        }
    
        return temporaryBoard
    }


    func printBoard(_ board: [Tile])
    {
        let terminator = "  "
        let separator = "  "
        
        print("\n..KNOCKOUT BOARD..")
        
        for x in 0..<board.count
        {
            if x < 4
            {
                print(board[x].display, terminator: terminator)
            }
            if x > 4 && x < 9
            {
                print(board[x].display, terminator: terminator)
            }
            if x > 9 && x < 13
            {
                print(board[x].display, terminator: terminator)
            }
            if x > 13 && x < 19
            {
                print(board[x].display, terminator: terminator)
            }
            if x > 19 && x < 24
            {
                print(board[x].display, terminator: terminator)
            }
            if x == 4
            {
                print(board[x].display, separator: separator)
            }
            if (x == 9) || (x == 14) || (x == 19)
            {
                print(board[x].display)
            }
            if x == 24
            {
                print(board[x].display, terminator: "\n\n") //, separator:"  ")
            }
        }
    }
    
    func printSelectedNumbers()
    {
        let first  = UserDefaults.standard.object(forKey: "firstSelected") as! Int
        let second = UserDefaults.standard.object(forKey: "secondSelected") as! Int
        let third  = UserDefaults.standard.object(forKey: "thirdSelected") as! Int
        let fourth = UserDefaults.standard.object(forKey: "fourthSelected") as! Int
        
        print("Your numbers are \(first), \(second), \(third), and \(fourth)")
    }
    
    func printCurrentInterface(){
        print("\n\nCurrent Interface: boardController")
    }
    
    
    func whichButton(_ number : Int) -> WKInterfaceButton{
        switch number{
        case 1: return one //when are "self"s necessary?
        case 2: return two
        case 3: return three
        case 4: return four
        case 5: return five
        case 6: return six
        case 7: return seven
        case 8: return eight
        case 9: return nine
        case 10: return ten
        case 11: return eleven
        case 12: return twelve
        case 13: return thirteen
        case 14: return fourteen
        case 15: return fifteen
        case 16: return sixteen
        case 17: return seventeen
        case 18: return eighteen
        case 19: return nineteen
        case 20: return twenty
        case 21: return twentyOne
        case 22: return twentyTwo
        case 23: return twentyThree
        case 24: return twentyFour
        case 25: return twentyFive
            
        default: print("No button was picked."); return one
        }
    }
    
    func initializeBoardTargetAndTargetInfo(){
        
        initializeDictionaries()
        
//        if UserDefaults.standard.object(forKey: "knockOutTarget") == nil {
//            UserDefaults.standard.set(knockOutTarget,forKey:"knockOutTarget")
//            UserDefaults.standard.synchronize()
//        }
        
//        if UserDefaults.standard.object(forKey: "targetKOstatus") == nil {
//            UserDefaults.standard.set(targetKOstatus,forKey:"targetKOstatus")
//            UserDefaults.standard.synchronize()
//        }
    
        if UserDefaults.standard.object(forKey: "dictKOed") == nil {
            UserDefaults.standard.set(dictKOed,forKey:"dictKOed")
//            UserDefaults.standard.synchronize()
        }
        
        if UserDefaults.standard.object(forKey: "dictAttempt") == nil {
            UserDefaults.standard.set(dictAttempt,forKey:"dictAttempt")
//            UserDefaults.standard.synchronize()
        }
        
        if UserDefaults.standard.object(forKey: "dictOperation") == nil {
            UserDefaults.standard.set(dictOperation,forKey:"dictOperation")
//            UserDefaults.standard.synchronize()
        }

        
        /*
        dictKOed[x] = "no"
        dictAttempt[x] = 0
        dictOperation[x] = nil*/
        
    }
   
    
    func refreshBoard(){
        print("\nrefreshBoard()")
        
        print("Printing board before replaced with NSUserDefaults...")
        printBoard(board)
        
        print("Calling updateBoardWithNSUserDefaults")
        updateBoardWithNSUserDefaults()
        
        print("Printing board after replaced with NSUserDefaults...")
        printBoard(board)
    }
    
    
    func updateBoardWithNSUserDefaults(){
        print("\nupdateBoardWithNSUserDefaults()")

        var copyDictKOed = UserDefaults.standard.object(forKey: "dictKOed") as! [String: String]
        var copyDictAttempt = UserDefaults.standard.object(forKey: "dictAttempt") as! [String: Int]
        var copyDictOperation = UserDefaults.standard.object(forKey: "dictOperation") as! [String: String]
        
        
        print("\n\nCopy of KOed dict")
        print(copyDictKOed)
        
        print("\n\nCopy of Attempt dict")
        print(copyDictAttempt)
        
        print("\n\nCopy of Operation dict")
        print(copyDictOperation)
        
        dictKOed = copyDictKOed
        dictAttempt = copyDictAttempt
        dictOperation = copyDictOperation


        for x in 1...25 {
            board[x-1].KOed = copyDictKOed[String(x)]!
            board[x-1].attempts = copyDictAttempt[String(x)]!
            board[x-1].operation = copyDictOperation[String(x)]!
            board[x-1].update_display()
        }
    }
    
    
    
    
    
    func initializeDictionaries(){
        for x in 1...25{
            dictKOed[String(x)] = "no"
            dictAttempt[String(x)] = 0
            dictOperation[String(x)] = ""
            
        }
    }
    
    func saveBoardStatus(){
        print("\nFunction: saveBoardStatus()")
        
        print("Printing dictKOed, dictAttept, and dictOperation")
        print(dictKOed)
        print(dictAttempt)
        print(dictOperation)
        
        print("\n Saving dictKOed, dictAttept, and dictOperation to NSUserDefaults")
        UserDefaults.standard.set(dictKOed,forKey:"dictKOed")
        UserDefaults.standard.set(dictAttempt,forKey:"dictAttempt")
        UserDefaults.standard.set(dictOperation,forKey:"dictOperation")
//        UserDefaults.standard.synchronize()
        
        print("Calling function: printNSUserDefaultsForKOAndAttemptAndOperation()")
        printNSUserDefaultsForKOAndAttemptAndOperation()
    }
    
    func printNSUserDefaultsForKOAndAttemptAndOperation() {
        print("\nFunction: printNSUserDefaultsForKOAndAttemptAndOperation()")
        
        print("\n\nCopy of KOed dict:")
        print(UserDefaults.standard.object(forKey: "dictKOed")!)
        
        print("\n\nCopy of Attempt dict:")
        print(UserDefaults.standard.object(forKey: "dictAttempt")!)
        
        print("\n\nCopy of Operation dict:")
        print(UserDefaults.standard.object(forKey: "dictOperation")!)
        
    }
    
    
//    func updateScreenButton(_ number : Int) {
//        let tile = number - 1
//        let button = whichButton(number)
//        setTitle(button, tile)
//        
//    }
    
    func setTitle(_ buttonNumber : WKInterfaceButton, _ tile : Int){
        buttonNumber.setTitle(board[tile].display)
    }
    

}
