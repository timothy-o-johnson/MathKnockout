//
//  HowToKnockOutViewController.swift
//  NoNotif
//
//  Created by John Grönlund on 21/01/2017.
//  Copyright © 2017 John Groenlund. All rights reserved.
//

import UIKit

class HowToKnockOutViewController: UIViewController, GameEngineDelegate
{
    let engine = GameEngine.shared
    
    @IBOutlet weak var knockOutTargetButton: UIButton!
    @IBOutlet weak var knockOutLabel: UILabel!
    @IBOutlet var punches: [UIButton]!
    
    @IBAction func didTapRestart(_ sender: UIBarButtonItem)
    {
        let ac = UIAlertController(title: "Reset Game", message: "Are you sure?", preferredStyle: .actionSheet)
        
        let ok = UIAlertAction(title: "OK", style: .destructive) { _ in
            self.engine.resetGame()
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(ok)
        ac.addAction(cancel)
        
        present(ac, animated: true, completion: nil)
        
    }
    
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
        
//        engine.delegate = self
//        engine.knockOutTarget = 1
//        knockOutTargetButton.titleLabel?.text = String(engine.knockOutTarget)
        
    
//    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        knockOutLabel.backgroundColor = .clear // http://stackoverflow.com/a/19261362
        knockOutLabel.layer.backgroundColor = UIColor.white.cgColor
        
        knockOutTargetButton.setTitle(String(engine.knockOutTarget), for: .normal)
        
        navigationItem.hidesBackButton = true
        
        // FIXME: Load Program
//        let op = engine.tiles[engine.knockOutTarget - 1].operation
//        knockOutLabel.text = op
//        engine.program = op.characters
//        engine.internalProgram = engine.tiles[engine.knockOutTarget - 1].operation
//        engine.entryStack.items = Array(op.characters)
//        engine.
        knockOutLabel.text = "=" + engine.displayableProgram // needed?
        
        // sort for ui
//        let sortedPunches = engine.punches.sorted { $0.0.punchValue < $0.1.punchValue }
        
        for i in 0..<punches.count {
            print("will set puch button to \(engine.punches[i].selected)")
            punches[i].isSelected = engine.punches[i].selected
            punches[i].setTitle(String(engine.punches[i].punchValue), for: .normal)
//            punches[i].setTitle(String(sortedPunches[i].punchValue), for: .normal)
            punches[i].layer.backgroundColor = punches[i].isSelected ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor
        }
//        punches[0].setTitle(String(engine.punches[0].punchValue), for: .normal)
//        punches[1].setTitle(String(engine.punches[1].punchValue), for: .normal)
//        punches[2].setTitle(String(engine.punches[2].punchValue), for: .normal)
//        punches[3].setTitle(String(engine.punches[3].punchValue), for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
//        knockOutLabel.backgroundColor = .clear
        
//        UIView.animate(withDuration: 0.2, animations: {
//            self.knockOutLabel.layer.backgroundColor = UIColor.red.cgColor
//        }) { _ in
//            UIView.animate(withDuration: 0.5) {
//                self.knockOutLabel.layer.backgroundColor = UIColor.clear.cgColor
//            }
//        }
    }
    
//    func hasPunchBeenSelected(_ number : Int) -> Bool
//    {
//        return punches[number].selected
//    }
    
    @IBAction func didTapPunch(_ sender: UIButton)
    {
//        let punchValue = Int(sender.titleLabel!.text!)
        
//        let punchNumber = 1
        
//        print("\nPunch #\(punchNumber) tapped with value of \(punchValue)")

        if !sender.isSelected
        {
//            let previous = knockOutLabel.text!
//            let new      = previous + punchValue
//            let punchValue = Character(sender.titleLabel!.text!)
            
//            let punch = Punch(
//                num        : sender.tag,
//                punchValue : Int(sender.currentTitle!)!,
//                selected   : sender.isSelected
//            )
            
//            engine.sendPunchValueToScreen(punch: punch)
            engine.sendPunchValueToScreen(index: sender.tag - 1)
//            engine.sendPunchValueToScreen(punch: engine.punches[sender.tag - 1])
            
//            engine.sendPunchValueToScreen(punch: engine.punches[Int(sender.currentTitle!)!]) //- 1])
//            engine.sendPunchValueToScreen(punchValue: punchValue)
//            engine.sendPunchValueToScreen(punchValue: punchValue)
        }
        
//        punches[number].selected
//        if hasPunchBeenSelected(number - 1) == false
//        {
        
//        }
        
//        engine.sendPunchToScreen(<#T##number: Int##Int#>, <#T##value: Int##Int#>)
//        sendPunchToScreen(punchNumber, punchValue)
//        printButtonStatusUpdate()
    }

    @IBAction func didTapOperation(_ sender: UIButton)
    {
//        print("\naddTapped")
        let labelText = sender.currentTitle!
        let operation = labelText == "x^y" ? "^" : labelText
//        let opChar    = Character(operation)
        
        engine.sendOperationToScreen(operation: operation)
    }
    
    @IBAction func didTapKnockOut(_ sender: UIButton)
    {
//        print(#function)
//        print("\nknockOut tapped")
        
        engine.knockOut()
        
//        attempt += 1
//        print("You have tried \(attempt) times to knock out \(knockOutTarget).")
//        
//        var stringToEvaluate = ""
//        
//        stringToEvaluate = convertStringForEvaluation(labelText)
//        
//        if stringToEvaluate != ""
//        {
//            if evaluateString(stringToEvaluate) == knockOutTarget
//            {
//                //                labelGroup.setBackgroundColor(UIColor(red: 0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1))
//                delegate?.setColorForLabelGroup(color: UIColor(red: 0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1))
//                
//                //blinking
//                sendTargetBackDefeated(knockOutTarget: knockOutTarget)//send to knock out board page
//            }
//        }
        
        //executes what's in the label
        //compares the result of the label to the knock out button
        //if true, flash pale green twice a record data to coredata class attributes
    }

    @IBAction func didTapDelete(_ sender: UIButton)
    {
//        print(#function)
//        print("\ndelete tapped()")
        //let temporaryString = labelText
        //var temporaryArray = convertStringToArray(temporaryString)
        
        engine.delete()
        
//        if labelText.isEmpty { return }
        
        //        else
        //        {
        
//        let counter = labelText.characters.index(before: labelText.endIndex)
        
        // let count = temporaryArray.count
        
//        let char = Int(String(labelText[counter]))
        
//        labelText.remove(at: labelText.characters.index(before: labelText.endIndex))
        
//        for x in 1...4
//        {
//            if char == punches[x-1].punchValue
//            {
//                punches[x-1].selected = false
//                //                changeButtonColor(x)
//                delegate?.changeButtonColor(buttonNum: x)
//                print("Changing punch #\(x)")
//                //                    howToKnockOutLabel.setText(labelText)
//                delegate?.printToLabel(text: labelText)
//            }
//            else
//            {
//                //                    howToKnockOutLabel.setText(labelText)
//                delegate?.printToLabel(text: labelText)
//            }
//        }
        //        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: GameEngineDelegate
    
    func printToLabel(text: String)
    {
        knockOutLabel.text = "=" + engine.displayableProgram // text
        
//        for i in 0...3 {
//            punches[i].isSelected      = engine.punches[i].selected
//            punches[i].alpha           = engine.punches[i].selected ? 0.3 : 1.0
//            punches[i].backgroundColor = engine.punches[i].selected ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor
            
//            punches[i].setTitle(<#T##title: String?##String?#>, for: <#T##UIControlState#>) = engine.punches[i].selected
//            punches[i].isSelected = engine.punches[i].selected
//        }
    }
    
    func didUpdatePunch(punch: Punch)
    {
        if let matchedPunch = punches.first(where: { Int($0.currentTitle!)! == punch.punchValue })
        {
            matchedPunch.isSelected = punch.selected // !matchedPunch.isSelected
//            matchedPunch.isEnabled  = !matchedPunch.isSelected
            matchedPunch.layer.backgroundColor = punch.selected ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor
            
//            matchedPunch.isHidden = punch.selected
//            matchedPunch.isSelected = punch.selected
//            matchedPunch.isSelected = punch.selected
//            matchedPunch.isEnabled  = punch.selected
        }
    }
    
//    func setColorForLabelGroup(color: UIColor)
    func didNotSucceed()
    {
//        view.backgroundColor = color // FIXME: knock out target button or display background
        
//        knockOutLabel.layer.backgroundColor = UIColor.white.cgColor
//        knockOutLabel.backgroundColor = .clear // http://stackoverflow.com/a/19261362
        
        UIView.animate(withDuration: 0.1, animations: {
            self.knockOutLabel.layer.backgroundColor = UIColor.red.cgColor
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.knockOutLabel.layer.backgroundColor = UIColor.white.cgColor
            }
        }
    }
    
    
    func sendTargetBackDefeated()
    {
        UIView.animate(withDuration: 0.1, animations: {
            self.knockOutLabel.layer.backgroundColor = UIColor.green.cgColor
        }) { _ in
            
            UIView.animate(withDuration: 0.3, animations: {
                self.knockOutLabel.layer.backgroundColor = UIColor.white.cgColor
            }, completion: { _ in
                _ = self.navigationController?.popViewController(animated: true)
            })
            
            
//            UIView.animate(withDuration: 0.5) {
//                self.knockOutLabel.layer.backgroundColor = UIColor.white.cgColor
//            }
        }
        
//        _ = navigationController?.popViewController(animated: true)
    }
}
