//
//  ChooseFourInterfaceController.swift
//  Math Knockout
//
//  Created by Tim Johnson on 11/30/15.
//  Copyright © 2015 Tim Johnson. All rights reserved.
//

import WatchKit
import Foundation

//struct SelectedPunches
//{
//    var first  : Int = 1
//    var second : Int = 1
//    var third  : Int = 1
//    var fourth : Int = 1
//}

class ChooseFourInterfaceController: WKInterfaceController
{
   /**
      storing data to UserDefaults and Moving to next screen take place in @IBAction func nextButton() {
     */
    
   
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
        
        // Store KOeds, attempts, and operations as three seperate dictionaries in UserDefaults
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
        changeSelectedStatus(numberTapped) // is number selected or unselected?
        changeButtonColor(numberTapped) // make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    
    @IBAction func twoTapped() {
        let numberTapped = 2
        changeSelectedStatus(numberTapped) // is number selected or unselected?
        changeButtonColor(numberTapped) // make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    @IBAction func threeTapped() {
        let numberTapped = 3
        changeSelectedStatus(numberTapped) // is number selected or unselected?
        changeButtonColor(numberTapped) // make it look like its selected or unselected
        narrateTapping(numberTapped)
    }

    @IBAction func fourTapped() {
        let numberTapped = 4
        changeSelectedStatus(numberTapped) // is number selected or unselected?
        changeButtonColor(numberTapped) // make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    @IBAction func fiveTapped() {
        let numberTapped = 5
        changeSelectedStatus(numberTapped) // is number selected or unselected?
        changeButtonColor(numberTapped) // make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    @IBAction func sixTapped() {
        let numberTapped = 6
        changeSelectedStatus(numberTapped) // is number selected or unselected?
        changeButtonColor(numberTapped) // make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    @IBAction func sevenTapped() {
        let numberTapped = 7
        changeSelectedStatus(numberTapped) // is number selected or unselected?
        changeButtonColor(numberTapped) // make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    @IBAction func eightTapped() {
        let numberTapped = 8
        changeSelectedStatus(numberTapped) // is number selected or unselected?
        changeButtonColor(numberTapped) // make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    @IBAction func nineTapped() {
        let numberTapped = 9
        changeSelectedStatus(numberTapped) // is number selected or unselected?
        changeButtonColor(numberTapped) // make it look like its selected or unselected
        narrateTapping(numberTapped)
    }
    
    @IBAction func nextButtonTapped() {
        if fourSelected(){
            print("Next button tapped. Four numbers have been selected.")
            
            let selectedButtons = numbers.filter { $0.selected }.sorted { $0.num < $1.num }

            engine.resetGame() // workaround since sometimes it would continue a game from here
        
            engine.punches = [
                Punch(num: 0, punchValue: selectedButtons[0].num),
                Punch(num: 1, punchValue: selectedButtons[1].num),
                Punch(num: 2, punchValue: selectedButtons[2].num),
                Punch(num: 3, punchValue: selectedButtons[3].num),
            ]
            
//            engine.resetGameToBeKOedAllButOne()
            
            let selectedPunches = storeSelectedPunchesInAStruct()
            let passThruContext : [String : Any] = ["selectedPunches" : selectedPunches]
            
            WKInterfaceController.reloadRootPageControllers(withNames: ["boardController"], contexts: [passThruContext], orientation: .horizontal, pageIndex: 0)
        } else {
             print("Next button tapped.")
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any?
    {
        print(#function)
        print(segueIdentifier)
        
        let selectedPunches = storeSelectedPunchesInAStruct()
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
        
        initializeBoardTargetAndTargetInfo() // seems like a waste since it's not stored in engine and is not passed to userDefaults or the next screen
        
        numbers = createNumbersList()
        // if no numbers in userDefaults initialize them
        let userDefaultNumbersExist = UserDefaults.standard.object(forKey: "firstSelected") != nil
        
        if !userDefaultNumbersExist {
            engine.initializeNumbersInUserDefaults()
        }
        // else updateNumbersInUserDefaults with selectedPunches ie do nothing because this is done in in WonInterfaceController
        
        self.synchronizeButtonsWithCurrentStatus()
        self.printSelectedNumbers()
        super.willActivate()
        
        updateNextButton()
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
        case 1: return numberOne
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
        
        updateNextButton()
    }
    
    func fourSelected() -> Bool{
        var count = 0
        for i in 0..<numbers.count {
            if numbers[i].selected == true {
                count += 1
            }
        }
        if count == 4 {
            makeNextButtonVisible()
            return true
        } else {
             print("\(String(count)) numbers chosen.")
            return false
        }
    }
    
    
    func storeSelectedPunchesInAStruct() -> SelectedPunches
    {
        var tempNumber = 0
        var count = 0
        var selected = SelectedPunches()
        
        for x in 0..<numbers.count
        {
            if numbers[x].selected == true
            {
                tempNumber = numbers[x].num
                count += 1
                
                switch count
                {
                    case 1  : selected.first  = tempNumber
                    case 2  : selected.second = tempNumber
                    case 3  : selected.third  = tempNumber
                    case 4  : selected.fourth = tempNumber
                    default : fatalError("Something's happening in saveSelectedNumbers()!") // crash immediately
                }

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
    
    func makeNextButtonVisible()
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
    
    func hideNextButton()
    {
        let attString = NSMutableAttributedString(string: "Next")
        attString.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], range: NSMakeRange(0, attString.length))
        self.next.setAttributedTitle(attString)
        self.next.setBackgroundColor(UIColor.clear)
    }
    
    func updateNextButton(){
        if fourSelected() {
            makeNextButtonVisible()
          } else {
              hideNextButton()
          }
        }
    
}
