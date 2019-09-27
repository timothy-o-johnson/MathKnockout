//
//  WonInterfaceController.swift
//  KO
//
//  Created by Tim Johnson on 08/03/2017.
//  Copyright © 2017 Tim Johnson. All rights reserved.
//

import WatchKit
import Foundation


class WonInterfaceController: WKInterfaceController
{
    let engine = GameEngine.shared
    
    @IBOutlet var quoteLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)
        // update UserDefaults with won game
        quoteLabel.setText(engine.randomInspirationalQuote())
    }
    
    @IBAction func didTapRestart()
    {
        engine.resetGame()

        WKInterfaceController.reloadRootPageControllers(withNames: ["SplashScreenController"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
    
    @IBAction func didTapPlayNextGameInSequence()
    {
        engine.resetGame()
        
        let currentGameCombo = engine.getCurrentGameCombination()
        engine.setGameCombinationToWin(currentGameCombo)
        let selectedPunches = engine.getPunchesForNextIncompleteGame()
        
        let passThruContext : [String : Any] = ["selectedPunches" : selectedPunches]
               
    WKInterfaceController.reloadRootPageControllers(withNames: ["boardController"], contexts: [passThruContext], orientation: .horizontal, pageIndex: 0)
        // WKInterfaceController.reloadRootPageControllers(withNames: ["SplashScreenController"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
}
