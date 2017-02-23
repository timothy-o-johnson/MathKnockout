//
//  BoardViewController.swift
//  NoNotif
//
//  Created by John Grönlund on 21/01/2017.
//  Copyright © 2017 John Groenlund. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController
{
    let engine = GameEngine.shared
    
    @IBOutlet var numberButtons: [UIButton]!
    
    @IBAction func numButtonTapped(_ sender: UIButton)
    {
        let vc = storyboard!.instantiateViewController(withIdentifier: "HowToKnockOutVC") as! HowToKnockOutViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.loadViewIfNeeded()
        engine.delegate = vc
        engine.knockOutTarget = sender.tag
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        for (index, tile) in engine.tiles.enumerated()
        {
            numberButtons[index].setTitle(tile.display, for: .normal)
        }
    }
    
}
