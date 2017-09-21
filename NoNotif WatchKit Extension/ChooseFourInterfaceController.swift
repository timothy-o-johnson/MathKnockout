//
//  ChooseFourInterfaceController.swift
//  Math Knockout
//
//  Created by Tim Johnson on 11/30/15.
//  Copyright © 2015 Tim Johnson. All rights reserved.
//

import WatchKit
import Foundation

struct SelectedPunches
{
    var first  : Int = 1
    var second : Int = 1
    var third  : Int = 1
    var fourth : Int = 1
}

class ChooseFourInterfaceController: WKInterfaceController
{
    let engine = GameEngine.shared
    
    func initializeBoardTargetAndTargetInfo()
    {
        var KOeds      = [String:String]()
        var attempts   = [String:Int]()
        var operations = [String:String]()
        
        (1...25).forEach {
            let key = String($0)
            KOeds[key]      = "no"
            attempts[key]   = 0
            operations[key] = ""
        }
        
        let defaults = UserDefaults.standard
        
        defaults.set(KOeds,      forKey:"dictKOed")
        defaults.set(attempts,   forKey:"dictAttempt")
        defaults.set(operations, forKey:"dictOperation")
    }

    
    var numbers = [number]()
        
    @IBOutlet var numberOne: WKInterfaceButton!
    @IBOutlet var numberTwo: WKInterfaceButton!
    @IBOutlet var numberThree: WKInterfaceButton!
    @IBOutlet var numberFour: WKInterfaceButton!
    @IBOutlet var numberFive: WKInterfaceButton!
    @IBOutlet var numberSix: WKInterfaceButton!
    @IBOutlet var numberSeven: WKInterfaceButton!
    @IBOutlet var numberEight: WKInterfaceButton!
    @IBOutlet var numberNine: WKInterfaceButton!
    
    @IBOutlet var next: WKInterfaceButton! //when FourSelected = true enable
   
    
    @IBAction func oneTapped() {
        let numberTapped = 1
        changeSelectedStatus(numberTapped) //is number selected or unselected?
        changeButtonColor(numberTapped) //make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    
    @IBAction func twoTapped() {
        let numberTapped = 2
        changeSelectedStatus(numberTapped) //is number selected or unselected?
        changeButtonColor(numberTapped) //make it look like its selected or unselected
       narrateTapping(numberTapped)
    }
    
    @IBAction func threeTapped() {
        let numberTapped = 3
        changeSelectedStatus(numberTapped) //is number selected or unselected?
        changeButtonColor(numberTapped) //make it look like its selected or unselected
       narrateTapping(numberTapped)
    }

    @IBAction func fourTapped() {
        let numberTapped = 4
        changeSelectedStatus(numberTapped) //is number selected or unselected?
        changeButtonColor(numberTapped) //make it look like its selected or unselected
       narrateTapping(numberTapped)
    }
    
    @IBAction func fiveTapped() {
        let numberTapped = 5
        changeSelectedStatus(numberTapped) //is number selected or unselected?
        changeButtonColor(numberTapped) //make it look like its selected or unselected
       narrateTapping(numberTapped)
    }
    
    @IBAction func sixTapped() {
        let numberTapped = 6
        changeSelectedStatus(numberTapped) //is number selected or unselected?
        changeButtonColor(numberTapped) //make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    @IBAction func sevenTapped() {
        let numberTapped = 7
        changeSelectedStatus(numberTapped) //is number selected or unselected?
        changeButtonColor(numberTapped) //make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    @IBAction func eightTapped() {
        let numberTapped = 8
        changeSelectedStatus(numberTapped) //is number selected or unselected?
        changeButtonColor(numberTapped) //make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    @IBAction func nineTapped() {
        let numberTapped = 9
        changeSelectedStatus(numberTapped) //is number selected or unselected?
        changeButtonColor(numberTapped) //make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    @IBAction func nextButton() {
        if fourSelected(){
            print("Next button tapped.  Four numbers have been selected.")
//            self.saveSelectedNumbers()
//            self.printSelectedNumbers()
//            let selectedPunches = saveSelectedNumbers()
//            self.presentController(withName: "boardController", context: selectedPunches)
//            self.presentController(withName: "boardController", context: nil)
            
//            let selectedButtons = numberButtons.filter { $0.isSelected }
            //        selectedButtons.first!.titleLabel!.text!
            
            let selectedButtons = numbers.filter { $0.selected }.sorted { $0.num < $1.num }
            
//            let selectedPunches = selectedButtons
//                .map { Punch(punchValue: $0.num) }
//                .sorted { $0.0.punchValue < $0.1.punchValue }
            
//            engine.punches = selectedPunches
        
            engine.punches = [
                Punch(num: 0, punchValue: selectedButtons[0].num),
                Punch(num: 1, punchValue: selectedButtons[1].num),
                Punch(num: 2, punchValue: selectedButtons[2].num),
                Punch(num: 3, punchValue: selectedButtons[3].num),
            ]
            
            let selectedPunches2 = saveSelectedNumbers()
            let passThruContext : [String : Any] = ["selectedPunches" : selectedPunches2]
            WKInterfaceController.reloadRootPageControllers(withNames: ["boardController"], contexts: [passThruContext], orientation: .horizontal, pageIndex: 0)
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any?
    {
        print(#function)
        print(segueIdentifier)
        
        let selectedPunches = saveSelectedNumbers()
        let passThruContext : [String : Any] = ["selectedPunches" : selectedPunches]
//        knockOutTarget
        return passThruContext
//        return selectedPunches
//        return "context from ChooseFourIC"
    }
    
    override func awake(withContext context: Any?) { // Configure interface objects here.
        print(#function)
        super.awake(withContext: context)
//       print(context)
    }

    override func willActivate() { // This method is called when watch view controller is about to be visible to user
        print("\n\nCurrent Interface: Choose Four")
        
        initializeBoardTargetAndTargetInfo()
        
        numbers = createNumbersList()
        initializeNumbers()
        self.synchronizeButtonsWithCurrentStatus()
        self.printSelectedNumbers()
        super.willActivate()
        
//        super.didDeactivate() // ????
        
        restoreNextButtonToDefault()
        
        
    }

    override func didDeactivate() {// This method is called when watch view controller is no longer visible
       
    }

    
    class number {
        let num : Int
        var selected = false
        
        init(_ num: Int) {
            self.num = num
        }
     }
    
    
    func createNumbersList() -> [number]{
        var numbers = [number]()
        let totalNumbers = 9
        
        for x in 0...(totalNumbers-1){
            let y = number(x+1)
            numbers.append(y)
        }
        return numbers
    }


    
    func printNumbers(_ anArray : [number]){
        let length = anArray.count
        
        for x in 0...(length-1){
            print(anArray[x].num)
        }
    }
    
        
    func changeButtonColor(_ number : Int){
        let button = whichButton(number)
        switch numbers[number - 1].selected {
        case true  : button.setBackgroundColor(UIColor.lightGray)
        case false : button.setBackgroundColor(UIColor.darkGray)
        //default: print("Warning: button color is not changing!")
        }
    }

    func whichButton(_ number : Int) -> WKInterfaceButton{
        switch number{
        case 1: return numberOne //when are "self"s necessary?
        case 2: return numberTwo
        case 3: return numberThree
        case 4: return numberFour
        case 5: return numberFive
        case 6: return numberSix
        case 7: return numberSeven
        case 8: return numberEight
        case 9: return numberNine
        case 10: return next
        default: print("No button was picked."); return numberOne
        }
    }

    func changeSelectedStatus(_ number : Int) {
        if numbers[number - 1].selected == false {
           numbers[number - 1].selected = true
        } else {
           numbers[number - 1].selected = false
        }
        
        if fourSelected() {
            next.setBackgroundColor(UIColor.darkGray)
        } else {
            next.setBackgroundColor(UIColor.clear)
        }
    }
    
    func fourSelected() -> Bool{
        var count = 0
        for i in 0..<numbers.count {
            if numbers[i].selected == true {
                count += 1
            }
        }
        if count == 4 {
            changeNextButtonFontandBackgroundColor()
            return true
        } else {
            print("Next button tapped. \(String(count)) numbers chosen.")
            return false
        }
    }
    
    
//    func saveSelectedNumbers()
    func saveSelectedNumbers() -> SelectedPunches
    {
        var tempNumber = 0
        var count = 0
        
//        var nums = [String : Int]()
        var selected = SelectedPunches()
        
        for x in 0..<numbers.count // no need to do: (numbers.count - 1) is us use ..< instead of ...
        {
            if numbers[x].selected == true
            {
                tempNumber = numbers[x].num
                count += 1
                
                switch count
                {
//                    case 1  : nums["1stSelected"] = tempNumber // UserDefaults.standard.set(tempNumber,forKey:"firstSelected")
//                    case 2  : nums["2ndSelected"] = tempNumber // UserDefaults.standard.set(tempNumber,forKey:"secondSelected")
//                    case 3  : nums["3rdSelected"] = tempNumber // UserDefaults.standard.set(tempNumber,forKey:"thirdSelected")
//                    case 4  : nums["4thSelected"] = tempNumber // UserDefaults.standard.set(tempNumber,forKey:"fourthSelected
                    case 1  : selected.first  = tempNumber // nums["firstSelected"] = tempNumber // UserDefaults.standard.set(tempNumber,forKey:"firstSelected")
                    case 2  : selected.second = tempNumber // nums["secondSelected"] = tempNumber // UserDefaults.standard.set(tempNumber,forKey:"secondSelected")
                    case 3  : selected.third  = tempNumber // nums["thirdSelected"] = tempNumber // UserDefaults.standard.set(tempNumber,forKey:"thirdSelected")
                    case 4  : selected.fourth = tempNumber // nums["fourthSelected"] = tempNumber // UserDefaults.standard.set(tempNumber,forKey:"fourthSelected")
                    default : fatalError("Something's happening in saveSelectedNumbers()!") // crash immediately
                }

//                UserDefaults.standard.synchronize()
            }
        }
        return selected
    }
        
    func printSelectedNumbers()
    {
        let first = UserDefaults.standard.object(forKey: "firstSelected") as! Int
        let second = UserDefaults.standard.object(forKey: "secondSelected") as! Int
        let third = UserDefaults.standard.object(forKey: "thirdSelected") as! Int
        let fourth = UserDefaults.standard.object(forKey: "fourthSelected") as! Int
        
        print("\nYour numbers are \(first),\(second),\(third), and \(fourth)")
    }
    
    func synchronizeNumbersWithCurrentStatus()
    {
        let first = UserDefaults.standard.object(forKey: "firstSelected") as! Int
        let second = UserDefaults.standard.object(forKey: "secondSelected") as! Int
        let third = UserDefaults.standard.object(forKey: "thirdSelected") as! Int
        let fourth = UserDefaults.standard.object(forKey: "fourthSelected") as! Int
        
        for x in 1...4
        {
            switch x
            {
                case 1: changeSelectedStatus(first)
                case 2: changeSelectedStatus(second)
                case 3: changeSelectedStatus(third)
                case 4: changeSelectedStatus(fourth)
                default: print("We didn't change shit.")
            }
        }
    }
    
    func synchronizeButtonsWithCurrentStatus()
    {
        synchronizeNumbersWithCurrentStatus()
        
        for x in 1...numbers.count
        {
            changeButtonColor(x)
        }
    }
    
    func changeNextButtonFontandBackgroundColor()
    {
        let attString = NSMutableAttributedString(string: "Next")
        attString.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], range: NSMakeRange(0, attString.length))
        self.next.setAttributedTitle(attString)
        self.next.setBackgroundColor(UIColor.darkGray)
    }
    
    
    func narrateTapping(_ numberTapped : Int)
    {
        print("Button \(self.numbers[numberTapped-1].num) tapped. Its current selected status is \(self.numbers[numberTapped-1].selected).")
    }
    
    func initializeNumbers()
    {
        UserDefaults.standard.set(1,forKey:"firstSelected")
        UserDefaults.standard.set(1,forKey:"secondSelected")
        UserDefaults.standard.set(1,forKey:"thirdSelected")
        UserDefaults.standard.set(1,forKey:"fourthSelected")
//        UserDefaults.standard.synchronize()
    }
    
    func restoreNextButtonToDefault()
    {
        let attString = NSMutableAttributedString(string: "Next")
        attString.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], range: NSMakeRange(0, attString.length))
        self.next.setAttributedTitle(attString)
    }
    
}
