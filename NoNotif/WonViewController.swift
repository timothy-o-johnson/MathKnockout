//
//  WonViewController.swift
//  KO
//
//  Created by Tim Johnson on 07/03/2017.
//  Copyright © 2017 Tim Johnson. All rights reserved.
//

import UIKit

class WonViewController: UIViewController
{
    let engine = GameEngine.shared
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        quoteLabel.text = engine.randomInspirationalQuote()
    }
    
    @IBAction func didTapRestart(_ sender: UIButton)
    {
        engine.resetGame()
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
