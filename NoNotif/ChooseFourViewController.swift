//
//  ChooseFourViewController.swift
//  NoNotif
//
//  Created by John Grönlund on 21/01/2017.
//  Copyright © 2017 John Groenlund. All rights reserved.
//

import UIKit


class ChooseFourViewController: UIViewController
{
    @IBOutlet var numberButtons: [UIButton]!
    
    let engine = GameEngine.shared
    
    @IBOutlet var nextButton  : UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let ps = numberButtons.filter { button in
            engine.punches.contains { punch in
                punch.punchValue == Int(button.currentTitle!)!
            }
        }
        ps.forEach(numButtonTapped)
    }

    @IBAction func numButtonTapped(_ button: UIButton)
    {
        button.isSelected = !button.isSelected
        button.layer.backgroundColor = button.isSelected ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor
        
        let selectedButtons = numberButtons.filter { $0.isSelected }
        nextButton.isHidden = selectedButtons.count != 4
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton)
    {
        let selectedButtons = numberButtons.filter { $0.isSelected }.sorted { $0.tag < $1.tag }
        
        engine.punches = [
            Punch(num: 0, punchValue: selectedButtons[0].tag),
            Punch(num: 1, punchValue: selectedButtons[1].tag),
            Punch(num: 2, punchValue: selectedButtons[2].tag),
            Punch(num: 3, punchValue: selectedButtons[3].tag),
        ]
    }
    
}
