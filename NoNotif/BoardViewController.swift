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
            numberButtons[index].isEnabled = !tile.KOed
        }
    }
    
    @IBAction func didTapRestart(_ sender: UIBarButtonItem)
    {
        let ac = UIAlertController(title: "Reset Game", message: "Are you sure?", preferredStyle: .actionSheet)
        
        let ok = UIAlertAction(title: "Start Over", style: .destructive) { _ in
            self.engine.resetGame()
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "Nevermind", style: .cancel, handler: nil)
        
        ac.addAction(ok)
        ac.addAction(cancel)
        
        present(ac, animated: true, completion: nil)
    }
    
}
