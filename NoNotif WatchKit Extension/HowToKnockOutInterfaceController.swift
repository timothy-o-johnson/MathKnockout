//
//  HowToKnockOutInterfaceController.swift
//  Math Knockout
//
//  Created by Tim Johnson on 11/30/15.
//  Copyright © 2015 Tim Johnson. All rights reserved.
//

import WatchKit
import Foundation


class HowToKnockOutInterfaceController: WKInterfaceController, GameEngineDelegate
{
    
    let engine = GameEngine.shared
    
    var first  = 0
    var second = 0
    var third  = 0
    var fourth = 0
    
    var labelText = ""
    var attempt = 0

    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any?
    {
        print(segueIdentifier)
        return "HowToKnockOutIC"
    }
    
    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)

        engine.delegate = self
        
        first  = engine.punches[0].punchValue
        second = engine.punches[1].punchValue
        third  = engine.punches[2].punchValue
        fourth = engine.punches[3].punchValue
    }
    
    override func willActivate()
    {
        super.willActivate()

        print("\n\nCurrent Interface: How To Knock Out\n")
        print("Your Knock Out Target is \(engine.knockOutTarget).")
        printSelectedNumbers()
        engine.printButtonStatusUpdate()
//        printNSUserDefaultsForKOAndAttemptAndOperation()
        
        knockOutTargetButton.setTitle(String(engine.knockOutTarget))
        
         firstPunch.setTitle(String(first))
        secondPunch.setTitle(String(second))
         thirdPunch.setTitle(String(third))
        fourthPunch.setTitle(String(fourth))
        
        howToKnockOutLabel.setText(engine.displayableProgram) // needed?
    }
    
    
    @IBAction func startOver()
    {
        engine.resetGame()
        
        WKInterfaceController.reloadRootControllers(withNames: ["SplashScreenController"], contexts: nil)
    }
    

    @IBOutlet var knockOutTargetButton: WKInterfaceButton!
    
    @IBOutlet var firstPunch: WKInterfaceButton!
    @IBOutlet var secondPunch: WKInterfaceButton!
    @IBOutlet var thirdPunch: WKInterfaceButton!
    @IBOutlet var fourthPunch: WKInterfaceButton!
    
    @IBOutlet var add: WKInterfaceButton!
    @IBOutlet var subtract: WKInterfaceButton!
    @IBOutlet var multiply: WKInterfaceButton!
    @IBOutlet var divide: WKInterfaceButton!
    
    @IBOutlet var openParenthesis: WKInterfaceButton!
    @IBOutlet var closedParenthesis: WKInterfaceButton!
    @IBOutlet var exponent: WKInterfaceButton!
    @IBOutlet var howToKnockOutLabel: WKInterfaceLabel!
    
    @IBOutlet var delete: WKInterfaceButton!
    
    @IBOutlet var labelGroup: WKInterfaceGroup!
    
    @IBAction func firstPunchTapped()
    {
        let punchValue = first
        let punchNumber = 1
        
        print("\nPunch #\(punchNumber) tapped with value of \(punchValue)")

        if hasPunchBeenSelected(0) == false
        {
            engine.sendPunchValueToScreen(index: 0)
        }
        
        engine.printButtonStatusUpdate()
    }
    
    @IBAction func secondPunchTapped()
    {
        let punchValue = second
        let punchNumber = 2
        
        print("\nPunch #\(punchNumber) tapped with value of \(punchValue)")

        if hasPunchBeenSelected(1) == false
        {
            engine.sendPunchValueToScreen(index: 1)
        }
        
        engine.printButtonStatusUpdate()
    }
    
    @IBAction func thirdPunchTapped()
    {
        let punchValue = third
        let punchNumber = 3
        
        print("\nPunch #\(punchNumber) tapped with value of \(punchValue)")

        if hasPunchBeenSelected(2) == false
        {
            engine.sendPunchValueToScreen(index: 2)
        }
        
        engine.printButtonStatusUpdate()
    }
    
    @IBAction func fourthPunchTapped()
    {
        let punchValue = fourth
        let punchNumber = 4
        
        print("\nPunch #\(punchNumber) tapped with value of \(punchValue)")
        
        if hasPunchBeenSelected(3) == false
        {
            engine.sendPunchValueToScreen(index: 3)
        }
        
        engine.printButtonStatusUpdate()
    }
    
    
    @IBAction func addTapped()               { engine.sendOperationToScreen(operation: "+") }
    @IBAction func subtractTapped()          { engine.sendOperationToScreen(operation: "-") }
    @IBAction func multiplyTapped()          { engine.sendOperationToScreen(operation: "x") }
    @IBAction func divideTapped()            { engine.sendOperationToScreen(operation: "/") }
    @IBAction func openParenthesisTapped()   { engine.sendOperationToScreen(operation: "(") }
    @IBAction func closedParenthesisTapped() { engine.sendOperationToScreen(operation: ")") }
    @IBAction func exponentTapped()          { engine.sendOperationToScreen(operation: "^") }
    
    
    @IBAction func knockOut()
    {
        engine.knockOut()
    }
    
    
    @IBAction func deleteTapped()
    {
        engine.delete()
    }
    
    
    func printSelectedNumbers()
    {
        print("Your numbers are \(first), \(second), \(third), and \(fourth)")
    }
    
    
    func changeButtonColor(_ number : Int)
    {
        let button = whichButton(number)
        
        switch engine.punches[number].selected
        {
            case true  : button.setBackgroundColor(.lightGray)
            case false : button.setBackgroundColor(.darkGray)
            //default: print("Warning: button color is not changing!")
        }
    }
    
    
    func whichButton(_ number : Int) -> WKInterfaceButton
    {
        switch number
        {
            case 0  : return firstPunch //when are "self"s necessary?
            case 1  : return secondPunch
            case 2  : return thirdPunch
            case 3  : return fourthPunch
            default : print("No button was picked."); return firstPunch
        }
    }
    
    
    func changeSelectedStatus(_ number : Int)
    {
        engine.punches[number].selected = !engine.punches[number].selected
    }
    
    
    func hasPunchBeenSelected(_ number : Int) -> Bool
    {
        return engine.punches[number].selected
    }

    
    // MARK: GameEngineDelegate
    
    func printToLabel(text: String)
    {
        howToKnockOutLabel.setText(engine.displayableProgram)
    }
    
    func didUpdatePunch(punch: Punch)
    {
        changeButtonColor(punch.num) //make it look like its selected or unselected
    }
    
    func didNotSucceed()
    {
        let rampUpTime   = 0.25
        let rampDownTime = 0.45
        
        animate(withDuration: rampUpTime)
        {
            self.labelGroup.setBackgroundColor(.red)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + rampUpTime)
        {
            self.animate(withDuration: rampDownTime)
            {
                self.labelGroup.setBackgroundColor(.clear)
            }
        }
    }
    
    
    func sendTargetBackDefeated()
    {
        let rampUpTime    = 0.25
        let rampDownTime  = 0.45
        let totalRampTime = rampUpTime + rampDownTime
        
        animate(withDuration: rampUpTime)
        {
            self.labelGroup.setBackgroundColor(UIColor(red: 0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + rampUpTime)
        {
            self.animate(withDuration: rampDownTime)
            {
                self.labelGroup.setBackgroundColor(.clear)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + totalRampTime)
        {
            WKInterfaceController.reloadRootControllers(withNames: ["boardController"], contexts: [])
        }
    }

}
