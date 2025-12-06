//
//  HowToKnockOutViewController.swift
//  MathKnockout
//
//  Created by Tim Johnson on 21/01/2017.
//  Copyright © 2017 Tim Johnson. All rights reserved.
//

import UIKit

class HowToKnockOutViewController: UIViewController, GameEngineDelegate
{
    let engine = GameEngine.shared
    
    @IBOutlet weak var knockOutTargetButton: UIButton!
    @IBOutlet weak var knockOutLabel: UILabel!
    @IBOutlet var punches: [UIButton]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        knockOutTargetButton.layoutIfNeeded()
        knockOutTargetButton.titleLabel?.minimumScaleFactor = 0.5
        knockOutTargetButton.titleLabel?.numberOfLines = 1
        knockOutTargetButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }

    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        knockOutTargetButton.applyRoundedStyle(radius: 12)
        punches.forEach { $0.applyRoundedStyle(radius: 10) }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        knockOutLabel.backgroundColor = .clear // http://stackoverflow.com/a/19261362
        knockOutLabel.layer.backgroundColor = UIColor.black.cgColor
        
        knockOutTargetButton.setTitle(String(engine.knockOutTarget), for: .normal)
        

        knockOutLabel.text = "=" + engine.evalStackDisplay // needed?
        
        for i in 0..<punches.count
        {
            print("will set puch button to \(engine.punches[i].selected)")
            punches[i].isSelected = engine.punches[i].selected
            punches[i].setTitle(String(engine.punches[i].punchValue), for: .normal)
            punches[i].layer.backgroundColor = punches[i].isSelected ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor
        }
    }
    
    
    @IBAction func didTapPunch(_ sender: UIButton)
    {
//        print("\nPunch #\(punchNumber) tapped with value of \(punchValue)")

        if !sender.isSelected
        {
            engine.sendPunchValueToScreen(index: sender.tag - 1)
        }
        
        engine.printButtonStatusUpdate()
    }
    
    
    @IBAction func didTapOperation(_ sender: UIButton)
    {
        let labelText = sender.currentTitle!
        let operation = labelText == "x^y" ? "^" : labelText
        
        engine.sendOperationToScreen(operation: operation)
    }
    
    @IBAction func didTapKnockOut(_ sender: UIButton)
    {
        engine.knockOut()
    }

    @IBAction func didTapDelete(_ sender: UIButton)
    {
        engine.delete()
    }
    
    
    
    // MARK: GameEngineDelegate
    
    func printToLabel(text: String)
    {
        knockOutLabel.text = "=" + engine.evalStackDisplay
    }
    
    func didUpdatePunch(punch: Punch)
    {
        if let matchedPunch = punches.first(where: { Int($0.currentTitle!)! == punch.punchValue })
        {
            matchedPunch.isSelected = punch.selected
            matchedPunch.layer.backgroundColor = punch.selected ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor
        }
    }
    
    func didNotSucceed()
    {
        UIView.animate(withDuration: 0.1, animations: {
            self.knockOutLabel.layer.backgroundColor = UIColor.red.cgColor
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.knockOutLabel.layer.backgroundColor = UIColor.black.cgColor
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
        }
    }
    
}
