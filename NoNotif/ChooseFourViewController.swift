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
    
    @IBOutlet var nextButton  : UIButton! //when FourSelected = true enable
    
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
                punch.punchValue == button.tag
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
        let selectedButtons = numberButtons.filter { $0.isSelected }
//        selectedButtons.first!.titleLabel!.text!
        let selectedPunches = selectedButtons.map {
            Punch(num: $0.tag, punchValue: Int($0.currentTitle!)!, selected: false)
        }
        
        engine.punches = selectedPunches
        
//        engine.saveSelectedPuches()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
