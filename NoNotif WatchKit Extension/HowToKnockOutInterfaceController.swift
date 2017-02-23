//
//  HowToKnockOutInterfaceController.swift
//  Math Knockout
//
//  Created by Tim Johnson on 11/30/15.
//  Copyright © 2015 Tim Johnson. All rights reserved.
//

import WatchKit
import Foundation
//import MathParser



class HowToKnockOutInterfaceController: WKInterfaceController, GameEngineDelegate {
    
    let engine = GameEngine.shared
    
//    var punches = [punch]()

    var first  = 0 // UserDefaults.standard.object(forKey: "firstSelected") as! Int
    var second = 0 // UserDefaults.standard.object(forKey: "secondSelected") as! Int
    var third  = 0 // UserDefaults.standard.object(forKey: "thirdSelected") as! Int
    var fourth = 0 // UserDefaults.standard.object(forKey: "fourthSelected") as! Int
    
//    var knockOutTarget = 0 // UserDefaults.standard.object(forKey: "knockOutTarget") as! Int
    
    var labelText = ""
    var attempt = 0
    
//    init() {
//        
//    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any?
    {
        print(#function)
        print(segueIdentifier)
        return "HowToKnockOutIC"
    }
    
    override func awake(withContext context: Any?) {
        print(#function)
        super.awake(withContext: context)
//        print(context!)
        // Configure interface objects here.
        
        engine.delegate = self
        
//        let passThruContext = context as! [String : Any]
//        let selected = passThruContext["selectedPunches"] as! SelectedPunches
        
//        let selected = context as! SelectedPunches
        
        first  = engine.punches[0].punchValue // selected.first
        second = engine.punches[1].punchValue // selected.second
        third  = engine.punches[2].punchValue // selected.third
        fourth = engine.punches[3].punchValue // selected.fourth
        
//        knockOutTargetButton.setTitle(String(engine.knockOutTarget), for: .normal)
        
//        knockOutTarget = engine.knockOutTarget
//        knockOutTarget = passThruContext["knockOutTarget"] as! Int
        
//        punches = createPunchesList(selected.first, secondPunch: selected.second, thirdPunch: selected.third, fourthPunch: selected.fourth)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        /*let knockOutTarget = NSUserDefaults.standardUserDefaults().objectForKey("knockOutTarget") as! Int*/
        
//        punches = createPunchesList(first, secondPunch: second, thirdPunch: third, fourthPunch: fourth)
        
//        print("\n\nCurrent Interface: How To Knock Out\n")
//        print("Your Knock Out Target is \(engine.knockOutTarget).")
//        printSelectedNumbers()
//        printButtonStatusUpdate()
//        printNSUserDefaultsForKOAndAttemptAndOperation()
        
        knockOutTargetButton.setTitle(String(engine.knockOutTarget))
        
         firstPunch.setTitle(String(first))
        secondPunch.setTitle(String(second))
         thirdPunch.setTitle(String(third))
        fourthPunch.setTitle(String(fourth))
        
//        self.howToKnockOutLabel.setText(labelText)
        howToKnockOutLabel.setText(engine.displayableProgram) // needed?
    }
    
//    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
//        super.didDeactivate()
//    }
    
    @IBAction func startOver() {
        resetGame()
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
//        let punchValue = first
//        let punchNumber = 1
        
//        print("\nPunch #\(punchNumber) tapped with value of \(punchValue)")
        
//        sendPunchToScreen(punchNumber, punchValue)
//        printButtonStatusUpdate()
     
//        firstPunch
        // FIXME: punch selection
//        if !sender.isSelected
//        {
            //            let previous = knockOutLabel.text!
            //            let new      = previous + punchValue
            //            let punchValue = Character(sender.titleLabel!.text!)
            
//            let punch = Punch(
//                num        : 1, //punchNumber, //sender.tag,
//                punchValue : engine.punches[0].punchValue, // first, // Int(sender.currentTitle!)!,
//                selected   : false // sender.isSelected
//            )
        
        
//        engine.sendPunchValueToScreen(punch: punch)
        
        if hasPunchBeenSelected(0) == false
        {
            engine.sendPunchValueToScreen(index: 0)
//            engine.sendPunchValueToScreen(punch: engine.punches[0])
        }
            //            engine.sendPunchValueToScreen(punchValue: punchValue)
            //            engine.sendPunchValueToScreen(punchValue: punchValue)
//        }
        
//        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func secondPunchTapped(){
//        let punchValue = second
//        let punchNumber = 2
        
//        print("\nPunch #\(punchNumber) tapped with value of \(punchValue)")
        
//        sendPunchToScreen(punchNumber, punchValue)
//        printButtonStatusUpdate()
        
//        let punch = Punch(
//            num        : 2, //punchNumber, //sender.tag,
//            punchValue : engine.punches[1].punchValue, //second, // Int(sender.currentTitle!)!,
//            selected   : false // sender.isSelected
//        )
        
//        engine.sendPunchValueToScreen(punch: punch)
        
        if hasPunchBeenSelected(1) == false
        {
            engine.sendPunchValueToScreen(index: 1)
//            engine.sendPunchValueToScreen(punch: engine.punches[1])
        }
    }
    
    @IBAction func thirdPunchTapped(){
//        let punchValue = third
//        let punchNumber = 3
        
//        print("\nPunch #\(punchNumber) tapped with value of \(punchValue)")
        
//        sendPunchToScreen(punchNumber, punchValue)
//        printButtonStatusUpdate()
        
//        let punch = Punch(
//            num        : 3, //punchNumber, //sender.tag,
//            punchValue : engine.punches[2].punchValue, //third, // Int(sender.currentTitle!)!,
//            selected   : false // sender.isSelected
//        )
        
//        engine.sendPunchValueToScreen(punch: punch)
        
        if hasPunchBeenSelected(2) == false
        {
            engine.sendPunchValueToScreen(index: 2)
//            engine.sendPunchValueToScreen(punch: engine.punches[2])
        }
    }
    
    @IBAction func fourthPunchTapped(){
//        let punchValue = fourth
//        let punchNumber = 4
        
//        print("\nPunch #\(punchNumber) tapped with value of \(punchValue)")
        
//        sendPunchToScreen(punchNumber, punchValue)
//        printButtonStatusUpdate()
        
//        let punch = Punch(
//            num        : 4, //punchNumber, //sender.tag,
//            punchValue : engine.punches[3].punchValue, //fourth, // Int(sender.currentTitle!)!,
//            selected   : false // sender.isSelected
//        )
        
//        engine.sendPunchValueToScreen(punch: punch)
        
        if hasPunchBeenSelected(3) == false
        {
            engine.sendPunchValueToScreen(index: 3)
//            engine.sendPunchValueToScreen(punch: engine.punches[3])
        }
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
        print("\nknockOut tapped")
        
        engine.knockOut()
        
        /*
        attempt += 1
        print("You have tried \(attempt) times to knock out \(knockOutTarget).")
        
        var stringToEvaluate = ""
        
        stringToEvaluate = convertStringForEvaluation(labelText)
        
        if stringToEvaluate == ""{
        } else {
            if evaluateString(stringToEvaluate) == knockOutTarget{
                labelGroup.setBackgroundColor(UIColor.init(red: 0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1))
                //blinking
                sendTargetBackDefeated2()//send to knock out board page
            } else {
                
            }
        }
        
        //executes what's in the label
        //compares the result of the label to the knock out button
        //if true, flash pale green twice a record data to coredata class attributes
        */
    }

    @IBAction func deleteTapped() {
        print("\ndelete tapped()")
        //let temporaryString = labelText
        //var temporaryArray = convertStringToArray(temporaryString)
        
        engine.delete()
        
        /*
        if labelText == ""{
        } else {
            let counter = labelText.characters.index(before: labelText.endIndex)
            
            //let count = temporaryArray.count
            
            let char = Int(String(labelText[counter]))
            
            labelText.remove(at: labelText.characters.index(before: labelText.endIndex))
            
            for x in 1...4{
                if char == punches[x-1].punchValue{
                    punches[x-1].selected = false
                    changeButtonColor(x)
                    print("Changing punch #\(x)")
                    howToKnockOutLabel.setText(labelText)
                } else {
                     howToKnockOutLabel.setText(labelText)
                }
            }
        }
        */
    }
    
    
    
    func printSelectedNumbers(){
//        let first = UserDefaults.standard.object(forKey: "firstSelected") as! Int
//        let second = UserDefaults.standard.object(forKey: "secondSelected") as! Int
//        let third = UserDefaults.standard.object(forKey: "thirdSelected") as! Int
//        let fourth = UserDefaults.standard.object(forKey: "fourthSelected") as! Int
        
        print("Your numbers are \(first), \(second), \(third), and \(fourth)")
    }
    
    func updateScreen(_ text : String, _ number : Int = 0){
        
        let previousLabelText = labelText
        let proposedLabelText = labelText + text
        
        print("\nsendToScreen()")
        print("Previous labelText:\(previousLabelText)")
        print("Proposed labelText:\(proposedLabelText)")
      
        labelText = proposedLabelText
        print("New labelText:\(labelText)")
        howToKnockOutLabel.setText(labelText)
        
    }
    
    
    func convertStringToArray(_ aString : String) -> [Character]{
        let string : String = aString
        let characters = Array(string.characters)
        
        return characters
    }
    
    func willTwoConsecutiveNumbersHaveBeenEntered(_ proposedString : [Character]) -> Bool{
        let count = proposedString.count
        
        print("\nwillTwoConsecutiveNumbersHaveBeenEntered()")
        print("Stringcount = \(String(count))")
        print("Proposed String: \(String(proposedString))")
        
        if count<2{
            print("false")
            return false
        }
    
        let ultimate = proposedString[count-1]
        print("ultimate = \(String(ultimate))")
        
        let penUltimate = proposedString[count - 2]
        print("penUltimate = \(String(penUltimate))")
        
        if checkIfInt(ultimate) && checkIfInt(penUltimate){
            print("true")
            return true
        } else {
            print("false")
            return false
        }
    }
    
    func haveTwoConsecutiveOperatorsBeenEntered(_ newString : [Character]) -> Bool{
        let count = newString.count
        
        print("\nhaveTwoConsecutiveOperatorsHaveBeenEntered()")
        print("Stringcount = \(String(count))")
        print("Current String:\(String(newString))")
        
        if count<2{
            print("false")
            return false
        }
        
        let ultimate = newString[count - 1]
        let penUltimate = newString[count - 2]
        
        
        if checkIfOperator(ultimate) && checkIfOperator(penUltimate){
            print("true")
            return true
        } else {
            print("false")
            return false
        }
    }
    
    /*
    func hasThisNumberBeenEnteredAlready(_ number : Int) -> Bool{
        let punchNumber = number
        print("\nhasThisNumberBeenEnteredAlready()")
        print((String(punches[punchNumber].selected)))
        return punches[punchNumber].selected
    }
   */
    
    func checkIfInt(_ something : Character) -> Bool{
        switch something{
        case "0": return true
        case "1": return true
        case "2": return true
        case "3": return true
        case "4": return true
        case "5": return true
        case "6": return true
        case "7": return true
        case "8": return true
        case "9": return true
        default: return false
        }
    }
    
    func checkIfOperator(_ something : Character) -> Bool{
        switch something{
        case "+": return true
        case "-": return true
        case "x": return true
        case "/": return true
        //case "(": return true
        //case ")": return true
        case "^": return true
        default: return false
        }
    }
    
    class punch {
        let num : Int
        let punchValue : Int
        var selected = false
        
        init(_ num: Int, punchValue: Int) { //add variable to pass through for punchValue
            self.num = num
            self.punchValue = punchValue
        }
    }
    
    
    func createPunchesList(_ firstPunch : Int, secondPunch : Int, thirdPunch : Int, fourthPunch : Int) -> [punch]{
        var punches = [punch]()
        let totalPunches = 4
        
        for x in 0...(totalPunches-1){
            switch x+1{
            case 1: punches.append(newPunch(x, value: firstPunch))
            case 2: punches.append(newPunch(x, value: secondPunch))
            case 3: punches.append(newPunch(x, value: thirdPunch))
            case 4: punches.append(newPunch(x, value: fourthPunch))
            default: print("Error in PunchesList function")
            }
        }
        return punches
    }
    
    func newPunch(_ number : Int, value : Int) -> punch{
        let y = punch(number + 1, punchValue: value)
        //print(y.punchValue)
        return y
    }

    
    func changeButtonColor(_ number : Int){
        let button = whichButton(number)
        switch engine.punches[number].selected
        {
            case true  : button.setBackgroundColor(.lightGray)
            case false : button.setBackgroundColor(.darkGray)
            //default: print("Warning: button color is not changing!")
        }
    }
    
    func whichButton(_ number : Int) -> WKInterfaceButton{
        switch number{
        case 0: return firstPunch //when are "self"s necessary?
        case 1: return secondPunch
        case 2: return thirdPunch
        case 3: return fourthPunch
        default: print("No button was picked."); return firstPunch
        }
    }
    
    func changeSelectedStatus(_ number : Int)
    {
        engine.punches[number].selected = !engine.punches[number].selected
        
//        if engine.punches[number - 1].selected
//        {
//            self.punches[number - 1].selected = false
//        }
        
//        if self.punches[number - 1].selected == false
//        {
//            self.punches[number - 1].selected = true
//        }
//        else
//        {
//            self.punches[number - 1].selected = false
//        }
    }
    
    func hasPunchBeenSelected(_ number : Int) -> Bool{
        return engine.punches[number].selected
    }
    
    func printButtonStatusUpdate(){
        let count = engine.punches.count
        
        print("\nprintButtonStatusUpdate()")
        
        for x in 0..<count{
            print("Punch #\(x+1), Value \(engine.punches[x].punchValue), Selected: \(engine.punches[x].selected)")
        }
    }
    
    func sendPunchToScreen(_ number: Int, _ value: Int){
        if hasPunchBeenSelected(number-1) == false{
            if willTwoConsecutiveNumbersHaveBeenEntered(convertStringToArray(labelText+String(value))) == false{
                changeSelectedStatus(number) // has punch been selected or unselected?
                changeButtonColor(number) //make it look like its selected or unselected
                updateScreen(String(value), number)
            }
        } else{
        
        }
    }
    
    func sendOperationToScreen(_ operation: String){
        print("\nsendOperationToScreen()")
        let proposedLabelText = labelText + operation
        
        print("Proposed text label:\(proposedLabelText)")
        
        if haveTwoConsecutiveOperatorsBeenEntered(convertStringToArray(proposedLabelText)) == false{
            updateScreen(operation)
        } else{
            
        }
    }
  
    func evaluateString(_ aString : String) -> Int{
        var returnvalue:Double?
        
        do {
//            returnvalue = try aString.evaluate() // FIXME: quick
            NSLog("\(returnvalue)")
            
        }
//        catch {
//            NSLog("error came")
//            returnvalue = 0
//        }
        
        return Int(returnvalue!)        /*let expression = NSExpression(format:aString)
        
        
        if let result = expression.expressionValueWithObject(nil, context: nil) as? NSNumber {
            print(String(Int(result)))
            return Int(result)
        } else {
            print("-404")
            return -404
        }*/
    }
 
    func sendTargetBackDefeated2() {
        
        var copyDictKOed = UserDefaults.standard.object(forKey: "dictKOed") as! [String: String]
        var copyDictAttempt = UserDefaults.standard.object(forKey: "dictAttempt") as! [String: Int]
        var copyDictOperation = UserDefaults.standard.object(forKey: "dictOperation") as! [String: String]
        
        print("\nCopy of KOed dict: Before")
        print(copyDictKOed)
        
        print("\n\nCopy of Attempt dict: Before")
        print(copyDictAttempt)
        
        print("\n\nCopy of Operation dict: Before")
        print(copyDictOperation)
        
        copyDictKOed[String(engine.knockOutTarget)] = "yes"
        copyDictAttempt[String(engine.knockOutTarget)] = attempt
        copyDictOperation[String(engine.knockOutTarget)] = labelText
        
        print("\n\nCopy of KOed dict: After")
        print(copyDictKOed)
        
        print("\n\nCopy of Attempt dict: After")
        print(copyDictAttempt)
        
        print("\n\nCopy of Operation dict: After")
        print(copyDictOperation)
        
        UserDefaults.standard.set(copyDictKOed,forKey:"dictKOed")
        UserDefaults.standard.set(copyDictAttempt,forKey:"dictAttempt")
        UserDefaults.standard.set(copyDictOperation,forKey:"dictOperation")
        
        UserDefaults.standard.synchronize()
        
        printNSUserDefaultsForKOAndAttemptAndOperation()
        
        
//        self.presentController(withName: "boardController", context: true)
//        dismiss()
        pop()
        
    }
    
    func printNSUserDefaultsForKOAndAttemptAndOperation() {
        print("\n\nCopy of KOed dict: After")
        print(UserDefaults.standard.object(forKey: "dictKOed")!)
        
        print("\n\nCopy of Attempt dict: After")
        print(UserDefaults.standard.object(forKey: "dictAttempt")!)
        
        print("\n\nCopy of Operation dict: After")
        print(UserDefaults.standard.object(forKey: "dictOperation")!)
        
    }
    
    func convertStringForEvaluation(_ someString: String) -> String {
        print("\n fuction: convertStringForEvaluation")
        let startingString = someString
        print("\n startingString: \(startingString)")
        
        let secondString = startingString.replacingOccurrences(of: "^", with: "**")
        print("\n secondString: \(secondString)")
        
        let thirdString = secondString.replacingOccurrences(of: "x", with: "*")
        print("\n thirdString: \(thirdString)")
        
        return thirdString
    
    }
    
    func resetGame()
    {
        engine.resetGame()
        
        /*
        print("\nFunction: resetGame()")
     //create three dictionaries
        var dictKOed = [String: String]()
        var dictAttempt = [String: Int]()
        var dictOperation = [String: String]()
        
     //set them to zero
        
        for x in 1...25{
            dictKOed[String(x)] = "no"
            dictAttempt[String(x)] = 0
            dictOperation[String(x)] = ""
            
        }
        
     //save them to NSUserDefault
        UserDefaults.standard.set(dictKOed,forKey:"dictKOed")
        UserDefaults.standard.set(dictAttempt,forKey:"dictAttempt")
        UserDefaults.standard.set(dictOperation,forKey:"dictOperation")
//        UserDefaults.standard.synchronize()

        
     //insert number initializer
//        UserDefaults.standard.set(0,forKey:"firstSelected")
//        UserDefaults.standard.set(0,forKey:"secondSelected")
//        UserDefaults.standard.set(0,forKey:"thirdSelected")
//        UserDefaults.standard.set(0,forKey:"fourthSelected")
        
//        UserDefaults.standard.synchronize()
    */
     //send to punches interface
//        self.presentController(withName: "chooseNumbersController", context: nil)
//        popToRootController()
        WKInterfaceController.reloadRootControllers(withNames: ["SplashScreenController"], contexts: nil)
//        pop()
    }


    
    func resetDictionaries(){
        var dictKOed = [String: String]()
        var dictAttempt = [String: Int]()
        var dictOperation = [String: String]()
        
        for x in 1...25{
            dictKOed[String(x)] = "no"
            dictAttempt[String(x)] = 0
            dictOperation[String(x)] = ""
            
        }
    }
    
    
    // MARK: GameEngineDelegate
    
    func printToLabel(text: String)
    {
//        howToKnockOutLabel.setText("=" + engine.displayableProgram)
        howToKnockOutLabel.setText(engine.displayableProgram)
//        knockOutLabel.text = "=" + engine.displayableProgram
    }
    
    func didUpdatePunch(punch: Punch)
    {
        let number = punch.num
//        changeSelectedStatus(number) // has punch been selected or unselected?
        changeButtonColor(number) //make it look like its selected or unselected
//        updateScreen(String(value), number)
        
//        if let matchedPunch = punches.first(where: { $0.tag == punch.num })
//        {
//            matchedPunch.isSelected = !matchedPunch.isSelected
//            matchedPunch.layer.backgroundColor = matchedPunch.isSelected ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor
//        }
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
