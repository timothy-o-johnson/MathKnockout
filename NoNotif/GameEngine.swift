//
//  GameEngine.swift
//  NoNotif
//
//  Created by John Grönlund on 21/01/2017.
//  Copyright © 2017 John Groenlund. All rights reserved.
//

import Foundation
import MathParser

import UIKit.UIColor
//import WatchKit.UIColor

enum Operand : String
{
    case add      = "+"
    case subtract = "-"
    case multipy  = "*"
    case divide   = "/"
}

struct Punch
{
    let num        : Int
    let punchValue : Int
    var selected   = false
    
//    init(_ num: Int, punchValue: Int) // add variable to pass through for punchValue
//    {
//        self.num = num
//        self.punchValue = punchValue
//    }
}

struct Tile2
{
    let number    : Int
    var KOed      : Bool
    var operation : [Any]
    var attempts  = 0
    
    var display : String {
        get {
            return KOed ? "X" : String(number)
        }
    }
    
//    init(_ number: Int)
//    {
//        self.number = number
//        
//        if self.number < 10
//        {
//            self.display = " " + String(self.number)
//        }
//        else
//        {
//            self.display = String(self.number)
//        }
//    }
    
//    func update_display()
//    {
//        if self.KOed == "no"
//        {
//            if self.number < 10
//            {
//                self.display = " " + String(self.number)
//            }
//            else
//            {
//                self.display = String(self.number)
//            }
//        }
//        else
//        {
//            self.display = " X"
//            self.KOed = "yes"
//        }
//    }
}

struct StringStack
{
    var items = [Character]() {
        didSet {
            print(description)
        }
    }
    
    mutating func push(_ item: Character)
    {
        items.append(item)
    }
    
    mutating func pop() -> Character
    {
        return items.removeLast()
    }
    
//    public func
    var description : String
    {
        return String(items)
    }
}

//struct Stack<Element>
//{
//    var items = [Element]()
//    
//    mutating func push(_ item: Element)
//    {
//        items.append(item)
//    }
//    
//    mutating func pop() -> Element
//    {
//        return items.removeLast()
//    }
//    
//    func description()
//    {
//        return String(items)
//    }
//}


//@objc
protocol GameEngineDelegate
{
    func printToLabel(text: String)
    func setColorForLabelGroup(color: UIColor)
//    func changeButtonColor(buttonNum: Int)
    func didUpdatePunch(punch: Punch)
    func sendTargetBackDefeated()
}

class GameEngine //: NSObject
{
    static let shared = GameEngine()
    
//    private init() {}
    
    //FiXME: watch out if when this defaults to 0
    var knockOutTarget = UserDefaults.standard.integer(forKey: "knockOutTarget") {
        didSet {
            UserDefaults.standard.set(knockOutTarget, forKey: "knockOutTarget")
        }
    }
    
//    weak
    var delegate : GameEngineDelegate?
    
    var labelText = "" {
        didSet {
            delegate?.printToLabel(text: labelText)
        }
    }
    
    var tiles : [Tile2]
    {
        didSet {
            let savableTiles = tiles.map { tile -> [String:Any] in
                [
                    "number"    : tile.number,
                    "KOed"      : tile.KOed,
                    "attempts"  : tile.attempts,
                    "operation" : tile.operation
                ]
            }
            UserDefaults.standard.set(savableTiles, forKey:"tiles")
        }
    }
    
//    var entryStack = [Character]()
//    var entryStack = StringStack()
    
    
    typealias Operand = Character
    typealias Digit   = Int
    
//    private var internalProgram = [AnyObject]()
//    private var internalProgram = [Any]()
    var internalProgram = [Any]() // Int and Character or String
    {
        didSet {
//            let xxx = internalProgram.map { (x) -> String in
//                switch x
//                {
//                    case let i as Int       : return String(i)
//                    case let c as Character : return String(c)
//                    default                 : return ""
//                }
//                if let i = x as? Int {
//                    return String(i)
//                }
//                else if let c = x as? Character {
//                    return String(c)
//                }
//                else {
//                    return ""
//                }
//            }.joined()
            
//            let yyy = internalProgram.reduce("") { $0 + String(describing: $1) } // concatenates
//            let yyy = internalProgram.reduce("") { $0 + String(describing: $1) } // concatenates
//            let yyy = internalProgram.reduce("") { //(result, str) -> Result in
//                $0 + ($1 is Int ? $0 + String($1 as! Int) : String($1 as! Character))
//                $0 + String(describing: $1)
//            }
            
//            internalProgram
//            JoinedSequence(base: <#T##Base#>, separator: <#T##Separator#>)
//            print(internalProgram)
//            print("xxx: \(xxx)")
//            print("yyy: \(yyy)")
            delegate?.printToLabel(text: displayableProgram)
            
//            UserDefaults.standard.set(yyy, forKey: "program_string")
            UserDefaults.standard.set(internalProgram, forKey: "program_any")
//            UserDefaults.standard.set(internalProgram as AnyObject, forKey: "program_any_object")
//            UserDefaults.standard.set(arr, forKey: "internalProgram-nsArray")
            
//            let arr = NSMutableArray()
//            for operand in internalProgram {
//                if let opChar = operand as? Character {
//                    arr.add(String(opChar))
//                } else {
//                    arr.add(operand) // Int
//                }
//            }
//            arr.add(<#T##anObject: Any##Any#>)
//            UserDefaults.standard.set(arr, forKey: "internalProgram-nsArray")
//            let nsArr = UserDefaults.standard.array(forKey: "internalProgram-nsArray")
//            print(nsArr!)
//            print(nsArr)
            
            let anyArr = UserDefaults.standard.array(forKey: "program_any")
            print(anyArr!)
//            print(anyArr)
            
        }
    }
    
//    typealias PropertyList = AnyObject
    
    var displayableProgram : String {
        get {
            return internalProgram.reduce("") { $0 + String(describing: $1) } // concatenates
        }
    }
    
    var program : [Any] {
        get {
            return internalProgram // as GameEngine.PropertyList
        }
        set {
            internalProgram = program
//            clear()
//            if let arrayOfOps = newValue as? [Any] {
//                for op in arrayOfOps {
//                    if let operand = op as? Int {
            
//                    }
//                }
//            }
        }
    }
    
    var attemptCount = 0
    
    var punches = [Punch]() {
        didSet {
            if punches.count == 4 {
                let punchVals = punches.map { $0.punchValue }.sorted { $0 < $1 }
                UserDefaults.standard.set(punchVals, forKey:"selectedPunches")
                
//                UserDefaults.standard.set(punches[0].punchValue, forKey:"firstSelected")
//                UserDefaults.standard.set(punches[1].punchValue, forKey:"secondSelected")
//                UserDefaults.standard.set(punches[2].punchValue, forKey:"thirdSelected")
//                UserDefaults.standard.set(punches[3].punchValue, forKey:"fourthSelected")
            }
        }
    }
    
//    override
    private init()
    {
        if let savedTiles = UserDefaults.standard.array(forKey: "tiles") as? [[String:Any]]
        {
            tiles = savedTiles.map {
                Tile2(
                    number    : $0["number"]    as! Int,
                    KOed      : $0["KOed"]      as! Bool,
                    operation : $0["operation"] as! [Any],
                    attempts  : $0["attempts"]  as! Int
                )
            }
        }
        else // generate
        {
            tiles = (1...25).map {
                Tile2(
                    number    : $0,
                    KOed      : false,
                    operation : [Any](),
                    attempts  : 0
                )
            }
        }
        
//        super.init()
        
        if let punchVals = UserDefaults.standard.array(forKey: "selectedPunches") as? [Int] {
            for (index, num) in punchVals.enumerated() {
                punches.append(Punch(num: index, punchValue: num, selected: false))
            }
        }
        
//        punches.append(Punch(num: 1, punchValue: 1, selected: false))
//        punches.append(Punch(num: 2, punchValue: 2, selected: false))
//        punches.append(Punch(num: 3, punchValue: 4, selected: false))
//        punches.append(Punch(num: 4, punchValue: 9, selected: false))
        
//        resetGame()
    }
    
    func saveSelectedPuches()
    {
        UserDefaults.standard.set(punches[0].punchValue, forKey:"firstSelected")
        UserDefaults.standard.set(punches[1].punchValue, forKey:"secondSelected")
        UserDefaults.standard.set(punches[2].punchValue, forKey:"thirdSelected")
        UserDefaults.standard.set(punches[3].punchValue, forKey:"fourthSelected")
    }
    
//    var punch1 : Punch!
//    var punch2 : Punch!
//    var punch3 : Punch!
//    var punch4 : Punch!
   
//    func knockOut(knockOutTarget: Int)
    func knockOut()
    {
//        print("\nknockOut tapped")
        
        attemptCount += 1
//        print("You have tried \(attempt) times to knock out \(knockOutTarget).")
        
        
        if internalProgram.isEmpty { return }
        
//        var stringToEvaluate = ""
//        let stringToEvaluate = convertStringForEvaluation(String(entryStack.items))
        let stringToEvaluate = convertStringForEvaluation(displayableProgram)
//        stringToEvaluate = convertStringForEvaluation(labelText)
        
//        if stringToEvaluate != ""
//        {
        var resultingInt : Int? //""
        
        do
        {
            let resultDouble = try stringToEvaluate.evaluate()
            resultingInt = Int(resultDouble)
        }
        catch
        {
            print("could not evaluate \(stringToEvaluate)")
        }
        
        guard resultingInt != nil else { return }
        
        if resultingInt! == knockOutTarget
//        if evaluateString(stringToEvaluate) == knockOutTarget
        {
//                labelGroup.setBackgroundColor(UIColor(red: 0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1))
//            delegate?.setColorForLabelGroup(color: UIColor(red: 0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1))
            
            //blinking
//            sendTargetBackDefeated()//send to knock out board page
            
//            tiles[0].KOed = true
//            tiles[0].attempts = 5
//            tiles[0].operation = [1,"2",3,"4",5]
//            entryStack.description
            
            
            tiles[knockOutTarget - 1].KOed = true
            tiles[knockOutTarget - 1].attempts = attemptCount
            tiles[knockOutTarget - 1].operation = internalProgram // entryStack.description
            
            delegate?.sendTargetBackDefeated()
        }
//        }
        
        //executes what's in the label
        //compares the result of the label to the knock out button
        //if true, flash pale green twice a record data to coredata class attributes
    }
    
    
    
    func delete()
    {
//        print("\ndelete tapped()")
        //let temporaryString = labelText
        //var temporaryArray = convertStringToArray(temporaryString)
        
        if internalProgram.isEmpty { return }
//        if entryStack.items.isEmpty { return }
//        if labelText.isEmpty { return }
        
//        guard latest = entryStack.items.last else { return } // if empty
        
        if let removed = internalProgram.popLast() as? Int
        {
            if var matchingPunch = punches.first(where: { $0.punchValue == removed })
            {
                matchingPunch.selected = false
                delegate?.printToLabel(text: displayableProgram)
//                delegate?.printToLabel(text: entryStack.description)
                //            delegate?.didUpdatePunch(punch: matchingPunch)
            }
        }
//        internalProgram.removeLast()
//        _ = internalProgram.dropLast()
        
//        let removed = entryStack.pop()
//        else
//        {
//        let counter = entryStack.description.characters.index(before: labelText.endIndex)
//        let counter = labelText.characters.index(before: labelText.endIndex)
        
        // let count = temporaryArray.count
        
//        let char = Int(String(labelText[counter]))
        
//        labelText.remove(at: labelText.characters.index(before: labelText.endIndex))
//        let newLabelText = String(labelText.characters.dropLast())
        
//        let local = entryStack.items.first(where: {$0.sourceType == .Local})
//        let xx = entryStack.items.first(where: {return true})
        
//        let matchingPunch = punches.filter { $0.punchValue == removed }
        
//        if var matchingPunch = punches.first(where: { String($0.punchValue) == String(removed) })
//        {
//            matchingPunch.selected = false
//            delegate?.printToLabel(text: entryStack.description)
////            delegate?.didUpdatePunch(punch: matchingPunch)
//        }
        
//        punches
//            .filter  { $0.punchValue == removed }
//            .forEach { $0.selected   =  false   }
        
//        for x in 1...4
//        {
//            if char == punches[x - 1].punchValue
//            {
//                punches[x - 1].selected = false
////                changeButtonColor(x)
//                delegate?.changeButtonColor(buttonNum: x)
//                print("Changing punch #\(x)")
////                    howToKnockOutLabel.setText(labelText)
//                delegate?.printToLabel(text: newLabelText)
//            }
//            else
//            {
////                    howToKnockOutLabel.setText(labelText)
//                delegate?.printToLabel(text: newLabelText)
//            }
//        }
//        }
    }
    
    
    
//    func printSelectedNumbers()
//    {
        //        let first = UserDefaults.standard.object(forKey: "firstSelected") as! Int
        //        let second = UserDefaults.standard.object(forKey: "secondSelected") as! Int
        //        let third = UserDefaults.standard.object(forKey: "thirdSelected") as! Int
        //        let fourth = UserDefaults.standard.object(forKey: "fourthSelected") as! Int
        
//        print("Your numbers are \(first), \(second), \(third), and \(fourth)")
//    }
    
//    func updateScreen(_ text : String) //, _ number : Int = 0)
    func updateScreen() //, _ number : Int = 0)
    {
//        let previousLabelText = labelText
//        let proposedLabelText = labelText + text
        
//        print("\nsendToScreen()")
//        print("Previous labelText:\(previousLabelText)")
//        print("Proposed labelText:\(proposedLabelText)")
        
//        labelText = proposedLabelText
//        print("New labelText:\(labelText)")
//        howToKnockOutLabel.setText(labelText)
//        delegate?.printToLabel(text: labelText)
        
//        delegate?.printToLabel(text: entryStack.description)
        delegate?.printToLabel(text: displayableProgram)
    }
    
    
//    func convertStringToArray(_ aString : String) -> [Character]
//    {
//        let string : String = aString
//        let characters = Array(string.characters)
//        
//        return characters
//    }
    
    
    func isSameTypeAsLastEntry(latest : Any) -> Bool
    {
        guard internalProgram.count >= 1 else { return false }
        
        if let lastest = latest as? String
        {
            if lastest != "(" || lastest != ")"
            {
                return false
            }
        }
        
        if let last = internalProgram.last as? String
        {
            if last != "(" || last != ")"
            {
                return false
            }
        }
        
//        if internalProgram.last! != "(" || != ")"
        return type(of: latest) == type(of: internalProgram.last!)
    }
    
//    func willTwoConsecutiveNumbersHaveBeenEntered(nextChar : Character) -> Bool
//    {
//        guard entryStack.items.count >= 2 else { return false }
//        guard labelText.characters.count >= 2 else { return false }
//        return checkIfInt(nextChar) && checkIfInt(entryStack.items.last!)
//        return checkIfInt(nextChar) && checkIfInt(labelText.characters.last!)
//    }
    
    /*
    func willTwoConsecutiveNumbersHaveBeenEntered(_ proposedString : [Character]) -> Bool
    {
        let count = proposedString.count
        
//        print("\nwillTwoConsecutiveNumbersHaveBeenEntered()")
//        print("Stringcount = \(String(count))")
//        print("Proposed String: \(String(proposedString))")
        
        if count < 2
        {
            print("false")
            return false
        }
        
        proposedString.last
        proposedString.dropLast().last
        
        let ultimate = proposedString[count-1]
//        print("ultimate = \(String(ultimate))")
        
        let penUltimate = proposedString[count - 2]
//        print("penUltimate = \(String(penUltimate))")
        
        if checkIfInt(ultimate) && checkIfInt(penUltimate)
        {
//            print("true")
            return true
        }
        else
        {
//            print("false")
            return false
        }
    }
    */
//    func haveTwoConsecutiveOperatorsBeenEntered(nextChar : String) -> Bool
//    func haveTwoConsecutiveOperatorsBeenEntered(nextChar : Character) -> Bool
//    {
//        guard labelText.characters.count >= 2 else { return false }
//        guard entryStack.items.count >= 2 else { return false }
//        return checkIfOperator(nextChar) && checkIfOperator(labelText.characters.last)
//        return checkIfOperator(nextChar) && checkIfOperator(entryStack.items.last!)
//    }

    /*
    func haveTwoConsecutiveOperatorsBeenEntered(_ newString : [Character]) -> Bool
    {
        let count = newString.count
        
        print("\nhaveTwoConsecutiveOperatorsHaveBeenEntered()")
        print("Stringcount = \(String(count))")
        print("Current String:\(String(newString))")
        
        if count < 2
        {
            print("false")
            return false
        }
        
        let ultimate = newString[count - 1]
        let penUltimate = newString[count - 2]
        
        
        if checkIfOperator(ultimate) && checkIfOperator(penUltimate)
        {
            print("true")
            return true
        }
        else
        {
            print("false")
            return false
        }
    }
    */
    
//    func hasThisNumberBeenEnteredAlready(_ number : Int) -> Bool
//    {
//        let punchNumber = number
//        print("\nhasThisNumberBeenEnteredAlready()")
//        print((String(punches[punchNumber].selected)))
//        return punches[punchNumber].selected
//    }
    
    
//    func checkIfInt(_ something : Character) -> Bool
//    {
////        return Int(String(something)) != nil
//        
//        switch something
//        {
//            case "0" : return true
//            case "1" : return true
//            case "2" : return true
//            case "3" : return true
//            case "4" : return true
//            case "5" : return true
//            case "6" : return true
//            case "7" : return true
//            case "8" : return true
//            case "9" : return true
//            default  : return false
//        }
//    }
    
//    func checkIfOperator(_ something : Character) -> Bool
//    {
//        switch something
//        {
//            case "+" : return true
//            case "-" : return true
//            case "x" : return true
//            case "/" : return true
////            case "(" : return true
////            case ")" : return true
//            case "^" : return true
//            default  : return false
//        }
//    }

    
    /*
    func createPunchesList(_ firstPunch : Int, secondPunch : Int, thirdPunch : Int, fourthPunch : Int) -> [Punch]
    {
        var punches = [Punch]()
        let totalPunches = 4
        
        for x in 0...(totalPunches - 1)
        {
            switch x + 1
            {
                case 1  : punches.append(newPunch(x, value: firstPunch))
                case 2  : punches.append(newPunch(x, value: secondPunch))
                case 3  : punches.append(newPunch(x, value: thirdPunch))
                case 4  : punches.append(newPunch(x, value: fourthPunch))
                default : print("Error in PunchesList function")
            }
        }
        return punches
    }
    
    func newPunch(_ number : Int, value : Int) -> Punch
    {
        let y = Punch(number + 1, punchValue: value, selected: false)
        //print(y.punchValue)
        return y
    }
    */
    
//    func changeButtonColor(_ number : Int)
//    {
//        let button = whichButton(number)
        
//        switch punches[number - 1].selected
//        {
//            case true  : button.setBackgroundColor(UIColor.lightGray)
//            case false : button.setBackgroundColor(UIColor.darkGray)
//            default: print("Warning: button color is not changing!")
//        }
//    }
    
//    func whichButton(_ number : Int) -> WKInterfaceButton
//    {
//        switch number
//        {
//            case 1  : return firstPunch //when are "self"s necessary?
//            case 2  : return secondPunch
//            case 3  : return thirdPunch
//            case 4  : return fourthPunch
//            default : print("No button was picked."); return firstPunch
//        }
//    }
    
    
    
    func changeSelectedStatus(_ number : Int)
    {
        if self.punches[number - 1].selected == false
        {
            self.punches[number - 1].selected = true
        }
        else
        {
            self.punches[number - 1].selected = false
        }
    }
    
    func hasPunchBeenSelected(_ number : Int) -> Bool
    {
        return punches[number].selected
    }
    
    func printButtonStatusUpdate()
    {
        let count = punches.count
        
        print("\nprintButtonStatusUpdate()")
        
        for x in 0..<count
        {
            print("Punch #\(x+1), Value \(punches[x].punchValue), Selected: \(punches[x].selected)")
        }
    }
    
//    func sendPunchValueToScreen(punchValue: String)
//    func sendPunchValueToScreen(punchValue: Character)
    func sendPunchValueToScreen(punch: Punch)
    {
//        let previous = labelText!
//        let new = labelText + punchValue
//        let proposedLabelText = labelText + operation
        
//        let valChar = Character(String(punch.punchValue)) //as Digit
        
//        if hasPunchBeenSelected(number - 1) == false
//        {
//        let arr = Array(new.characters)
//        if willTwoConsecutiveNumbersHaveBeenEntered(Array(labelText.characters)) == false
        
        if isSameTypeAsLastEntry(latest: punch.punchValue) { return }
        
//        let res1 = isSameTypeAsLastEntry(latest: valChar) onlyAddToStackIfNotOfSameTypeAsLastOne(toTest: valChar)
//        let res2 = onlyAddToStackIfNotOfSameTypeAsLastOne(toTest: punch.punchValue)
        
//        if willTwoConsecutiveNumbersHaveBeenEntered(nextChar: valChar) { return }
        
//        {
//            changeSelectedStatus(number) // has punch been selected or unselected?
            //                changeButtonColor(number) //make it look like its selected or unselected
//            delegate?.changeButtonColor(buttonNum: number)
            //                updateScreen(String(value), number)
//            updateScreen(String(value))
        internalProgram.append(punch.punchValue)
//        entryStack.push(valChar)
//        updateScreen()
        
//        if var matchingPunch = punches.first(where: { String($0.punchValue) == String(valChar) })
//        {
//        var modifiedPunch = punch
//        modifiedPunch.selected = true
//            matchingPunch.selected = true
        
//        delegate?.printToLabel(text: entryStack.description)
        delegate?.printToLabel(text: displayableProgram)
//        delegate?.didUpdatePunch(punch: modifiedPunch)
//            delegate?.didUpdatePunch(punch: matchingPunch)
//        }
        
//        }
//        }
    }
    
    /*
    func sendPunchToScreen(_ number: Int, _ value: Int)
    {
        if hasPunchBeenSelected(number - 1) == false
        {
            if willTwoConsecutiveNumbersHaveBeenEntered(convertStringToArray(labelText+String(value))) == false
            {
                changeSelectedStatus(number) // has punch been selected or unselected?
//                changeButtonColor(number) //make it look like its selected or unselected
                delegate?.changeButtonColor(buttonNum: number)
//                updateScreen(String(value), number)
                updateScreen(String(value))
            }
        }
    }
    */
    
    func sendOperationToScreen(operation: String)
    {
//        print("\nsendOperationToScreen()")
//        let proposedLabelText = labelText + operation
        
//        print("Proposed text label:\(proposedLabelText)")

//        if operation != "(" || operation != ")"
//        {
        if isSameTypeAsLastEntry(latest: operation) { return }
//        }
        
        
        
//        if haveTwoConsecutiveOperatorsBeenEntered(nextChar: operation) { return }
//        if !haveTwoConsecutiveOperatorsBeenEntered(nextChar: operation) { return }
//        if haveTwoConsecutiveOperatorsBeenEntered(convertStringToArray(proposedLabelText)) { return }
//        if haveTwoConsecutiveOperatorsBeenEntered(convertStringToArray(proposedLabelText)) == false
//        {
//        updateScreen(operation)
        internalProgram.append(operation)
//        entryStack.push(operation)
        delegate?.printToLabel(text: displayableProgram)
//        updateScreen()
//        }
    }
    
    /*
    func sendOperationToScreen(_ operation: String)
    {
        print("\nsendOperationToScreen()")
        let proposedLabelText = labelText + operation
        
        print("Proposed text label:\(proposedLabelText)")
        
        if haveTwoConsecutiveOperatorsBeenEntered(convertStringToArray(proposedLabelText)) == false
        {
            updateScreen(operation)
        }
        else
        {
            
        }
    }
    */
    
    func evaluateString(_ aString : String) -> Int
    {
        var returnvalue : Double = 0.0 //Double?
        
        do
        {
            returnvalue = try aString.evaluate()
            NSLog("\(returnvalue)")
        }
        catch
        {
            NSLog("error came")
//            returnvalue = 0
        }
        
//        return Int(returnvalue!)
        return Int(returnvalue)
        
         /*let expression = NSExpression(format:aString)
         if let result = expression.expressionValueWithObject(nil, context: nil) as? NSNumber {
         print(String(Int(result)))
         return Int(result)
         } else {
         print("-404")
         return -404
         }*/
    }
    
    func sendTargetBackDefeated()
    {
//        var the25 = UserDefaults.standard.array(forKey: "the25") as! [[String:Any]]
        
        
//        let newEntry : [String:Any] = [
//            "KOed"      : true,
//            "attempts"  : attemptCount,
//            "operation" : entryStack.description
//        ]
        
//        the25[7] = newEntry
        
//        if knockOutTarget == 0 { fatalError() }
        
//        the25[knockOutTarget - 1] = newEntry
        
//        UserDefaults.standard.set(the25, forKey: "the25")
        
//        tiles[knockOutTarget - 1].KOed = true
//        tiles[knockOutTarget - 1].attempts = attemptCount
//        tiles[knockOutTarget - 1].operation = internalProgram // entryStack.description
        
        
        
        /*
        var copyDictKOed      = UserDefaults.standard.object(forKey: "dictKOed") as! [String: String]
        var copyDictAttempt   = UserDefaults.standard.object(forKey: "dictAttempt") as! [String: Int]
        var copyDictOperation = UserDefaults.standard.object(forKey: "dictOperation") as! [String: String]
        
        print("\nCopy of KOed dict: Before")
        print(copyDictKOed)
        
        print("\n\nCopy of Attempt dict: Before")
        print(copyDictAttempt)
        
        print("\n\nCopy of Operation dict: Before")
        print(copyDictOperation)
        
        

        
             copyDictKOed[String(knockOutTarget)] = "yes"
          copyDictAttempt[String(knockOutTarget)] = attemptCount
        copyDictOperation[String(knockOutTarget)] = labelText
        
        print("\n\nCopy of KOed dict: After")
        print(copyDictKOed)
        
        print("\n\nCopy of Attempt dict: After")
        print(copyDictAttempt)
        
        print("\n\nCopy of Operation dict: After")
        print(copyDictOperation)
        
        UserDefaults.standard.set(copyDictKOed,forKey:"dictKOed")
        UserDefaults.standard.set(copyDictAttempt,forKey:"dictAttempt")
        UserDefaults.standard.set(copyDictOperation,forKey:"dictOperation")
        
//        UserDefaults.standard.synchronize()
        
//        printNSUserDefaultsForKOAndAttemptAndOperation()
        */
        
        //        self.presentController(withName: "boardController", context: true)
        //        dismiss()
//        pop()
        
        delegate?.sendTargetBackDefeated()
    }
    
    
    
    func printNSUserDefaultsForKOAndAttemptAndOperation()
    {
        print("\n\nCopy of KOed dict: After")
        print(UserDefaults.standard.object(forKey: "dictKOed")!)
        
        print("\n\nCopy of Attempt dict: After")
        print(UserDefaults.standard.object(forKey: "dictAttempt")!)
        
        print("\n\nCopy of Operation dict: After")
        print(UserDefaults.standard.object(forKey: "dictOperation")!)
    }
    
    func convertStringForEvaluation(_ someString: String) -> String
    {
//        print("\n fuction: convertStringForEvaluation")
        
        let startingString = someString
//        print("\n startingString: \(startingString)")
        
        let secondString = startingString.replacingOccurrences(of: "^", with: "**")
//        print("\n secondString: \(secondString)")
        
        let thirdString = secondString.replacingOccurrences(of: "x", with: "*")
//        print("\n thirdString: \(thirdString)")
        
        return thirdString
    }
    /*
    func resetGame()
    {
//        print("\nFunction: resetGame()")
        
        // create three dictionaries
//        var dictKOed      = [String: String]()
//        var dictAttempt   = [String: Int]()
//        var dictOperation = [String: String]()
        
        let x = (1...25).map { num -> [String:Any] in
            [
                "KOed"      : false,
                "attempts"  : 0,
                "operation" : ""
            ]
        }
        
        UserDefaults.standard.set(x,forKey:"the25")
        
        tiles = (1...25).map {
            Tile2(
                number    : $0,
                KOed      : false,
                operation : [Any],
                attempts  : 0
            )
        }
        
        
        // set them to zero
//        for x in 1...25
//        {
//                 dictKOed[String(x)] = "no"
//              dictAttempt[String(x)] = 0
//            dictOperation[String(x)] = ""
//        }
        
        // save them to NSUserDefault
//        UserDefaults.standard.set(dictKOed,forKey:"dictKOed")
//        UserDefaults.standard.set(dictAttempt,forKey:"dictAttempt")
//        UserDefaults.standard.set(dictOperation,forKey:"dictOperation")
//        UserDefaults.standard.synchronize()
        
        
        //insert number initializer
        //        UserDefaults.standard.set(0,forKey:"firstSelected")
        //        UserDefaults.standard.set(0,forKey:"secondSelected")
        //        UserDefaults.standard.set(0,forKey:"thirdSelected")
        //        UserDefaults.standard.set(0,forKey:"fourthSelected")
        
        //        UserDefaults.standard.synchronize()
        
        //send to punches interface
        //        self.presentController(withName: "chooseNumbersController", context: nil)
//        popToRootController()
        //        pop()
    }
    */
    
    
//    func resetDictionaries()
//    {
//        var dictKOed      = [String: String]()
//        var dictAttempt   = [String: Int]()
//        var dictOperation = [String: String]()
//        
//        for x in 1...25
//        {
//                 dictKOed[String(x)] = "no"
//              dictAttempt[String(x)] = 0
//            dictOperation[String(x)] = ""
//        }
//    }
    

}
