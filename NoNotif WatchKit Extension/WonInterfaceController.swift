//
//  WonInterfaceController.swift
//  MathKnockout
//
//  Created by Tim Johnson on 08/03/2017.
//  Copyright © 2017 Tim Johnson. All rights reserved.
//

import WatchKit
import Foundation


class WonInterfaceController: WKInterfaceController
{
    let engine = GameEngine.shared
    var punches = SelectedPunches(
    first: 1,
    second: 1,
    third: 1,
    fourth: 1)
    
    @IBOutlet var quoteLabel: WKInterfaceLabel!
    @IBOutlet var playNextGame: WKInterfaceButton!
    
    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)
        // update UserDefaults with won game
        // move this to awake()
        let currentGameCombo = engine.getCurrentGameCombination()
        engine.setGameCombinationToWin(currentGameCombo)
        let selectedPunchesAndGameNumber = engine.getPunchesForNextIncompleteGame()
        // set punches in userDefault
        let nextGame = selectedPunchesAndGameNumber.gameNumber
        punches = selectedPunchesAndGameNumber.punches
        quoteLabel.setText(engine.randomInspirationalQuote() + "\n")
        playNextGame.setTitle(
            """
            Play Next Game:
              #\(nextGame) of 126
            """)
        
        
    }
    
    @IBAction func didTapPlayAgain()
    {
        engine.resetGame()
        //set user defaults to zero
        engine.initializeNumbersInUserDefaults()
        WKInterfaceController.reloadRootPageControllers(withNames: ["chooseNumbersController"], contexts: [], orientation: .horizontal, pageIndex: 0)
    }
    
    @IBAction func didTapPlayNextGameInSequence()
    {
        engine.resetGame()
        engine.updateSelectedPunchesInUserDefaults(punches: punches)
        //let passThruContext : [String : Any] = ["selectedPunches" : selectedPunches]
        WKInterfaceController.reloadRootPageControllers(withNames: ["chooseNumbersController"], contexts: [], orientation: .horizontal, pageIndex: 0)
        // WKInterfaceController.reloadRootPageControllers(withNames: ["SplashScreenController"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
}
