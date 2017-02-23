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
//        let vc = HowToKnockOutViewController()
//        present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
        vc.loadViewIfNeeded()
        engine.delegate = vc
        engine.knockOutTarget = sender.tag
        
//        for index in engine.punches.indices
//        {
//            engine.punches[index].selected = internalProgram.contains { $0 as? Int == engine.punches[index].punchValue }
//            delegate?.didUpdatePunch(punch: engine.punches[index])
//        }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
