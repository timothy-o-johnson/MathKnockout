//
//  GameEngine.swift
//  NoNotif
//
//  Created by Tim Johnson on 21/01/2017.
//  Copyright © 2017 Tim Johnson. All rights reserved.
//

import Foundation

struct Punch
{
    let num        : Int
    let punchValue : Int
    var selected   = false
    
    init(num: Int, punchValue: Int, selected : Bool = false) // add variable to pass through for punchValue
    {
        self.num = num
        self.punchValue = punchValue
        self.selected   = selected
    }
}

struct SelectedPunches
{
    var first  : Int = 1
    var second : Int = 1
    var third  : Int = 1
    var fourth : Int = 1
}

struct Tile
{
    let number    : Int
    var KOed      : Bool
    var operation : [Any]
    var attempts  = 0
    
    var display : String {
        get {
            return KOed ? "X" : String(number)
        }
    }
}

struct GameCombo : Codable
{
    let gameNumber: Int
    let gameCombo : String
    var won : Bool
    var dateWon: String
}

protocol GameEngineDelegate
{
    func printToLabel(text: String)
    func didNotSucceed()
    func didUpdatePunch(punch: Punch)
    func sendTargetBackDefeated()
}

class GameEngine
{
    static let shared = GameEngine()
    
    let gameCombinations = ["1234","1235","1236","1237","1238","1239","1245","1246","1247","1248","1249","1256","1257","1258","1259","1267","1268","1269","1278","1279","1289","1345","1346","1347","1348","1349","1356","1357","1358","1359","1367","1368","1369","1378","1379","1389","1456","1457","1458","1459","1467","1468","1469","1478","1479","1489","1567","1568","1569","1578","1579","1589","1678","1679","1689","1789","2345","2346","2347","2348","2349","2356","2357","2358","2359","2367","2368","2369","2378","2379","2389","2456","2457","2458","2459","2467","2468","2469","2478","2479","2489","2567","2568","2569","2578","2579","2589","2678","2679","2689","2789","3456","3457","3458","3459","3467","3468","3469","3478","3479","3489","3567","3568","3569","3578","3579","3589","3678","3679","3689","3789","4567","4568","4569","4578","4579","4589","4678","4679","4689","4789","5678","5679","5689","5789","6789"]

    
    var knockOutTarget = UserDefaults.standard.integer(forKey: "knockOutTarget") {
        didSet {
            UserDefaults.standard.set(knockOutTarget, forKey: "knockOutTarget")
            program = tiles[knockOutTarget - 1].operation
        }
    }
    
    var delegate : GameEngineDelegate?
    
    var labelText = "" {
        didSet {
            delegate?.printToLabel(text: labelText)
        }
    }
    
    var tiles : [Tile]
    {
        didSet {
            let savableTiles = tiles.map { tile -> [String:Any] in
                [
                    "number"    : tile.number,
                    "KOed"      : tile.KOed,
                    "attempts"  : tile.attempts,
                    "operation" : tile.operation
                ]
            }
            UserDefaults.standard.set(savableTiles, forKey:"tiles")
        }
    }
    
    var gameIsWon : Bool {
        get
        {
            for tile in tiles
            {
                if tile.KOed == false
                {
                    return false
                }
            }
            
            return true
        }
    }
    
    var program = [Any]()
    {
        didSet
        {
            delegate?.printToLabel(text: displayableProgram)
            
            print("current program: \(program)")
            
            for index in punches.indices
            {
                punches[index].selected = program.contains { $0 as? Int == punches[index].punchValue }
//                print("will update puch at index: \(index)")
                delegate?.didUpdatePunch(punch: punches[index])
            }
            
//            print(punches.map { $0.selected })
        }
    }
    
    var displayableProgram : String {
        get {
            return program.reduce("") { $0 + String(describing: $1) } // concatenates into String
        }
    }
    
    var attemptCount = 0
    
    var punches = [Punch]()
    {
        didSet
        {
            if punches.count == 4
            {
                let punchVals = punches.map { $0.punchValue }.sorted { $0 < $1 }
                UserDefaults.standard.set(punchVals, forKey:"selectedPunches")
            }
        }
    }
    
    private init()
    {
        if let savedTiles = UserDefaults.standard.array(forKey: "tiles") as? [[String:Any]]
        {
            tiles = savedTiles.map {
                Tile(
                    number    : $0["number"]    as! Int,
                    KOed      : $0["KOed"]      as! Bool,
                    operation : $0["operation"] as! [Any],
                    attempts  : $0["attempts"]  as! Int
                )
            }
        }
        else // generate
        {
            tiles = (1...25).map {
                Tile(
                    number    : $0,
                    KOed      : false,
                    operation : [Any](),
                    attempts  : 0
                )
            }
        }
        
        if let punchVals = UserDefaults.standard.array(forKey: "selectedPunches") as? [Int]
        {
            for (index, num) in punchVals.enumerated()
            {
                punches.append(Punch(num: index, punchValue: num))
            }
        }
    }

    func knockOut()
    {
        storeGameCombinationToMemory()
        
        attemptCount += 1
        
        print("You have tried \(attemptCount) times to knock out \(knockOutTarget).")

        if program.isEmpty { return }

        let stringToEvaluate = convertStringForEvaluation(displayableProgram)
        
        var resultingInt : Int?

        do
        {
            let resultDouble = try stringToEvaluate.evaluate()
            resultingInt = Int(resultDouble)
        }
        catch
        {
            print("could not evaluate \(stringToEvaluate)")
        }
        
        guard resultingInt != nil else { return }
        
        if resultingInt! == knockOutTarget
        {
            tiles[knockOutTarget - 1].KOed = true
            tiles[knockOutTarget - 1].attempts = attemptCount
            tiles[knockOutTarget - 1].operation = program
            
            delegate?.sendTargetBackDefeated()
        }
        else
        {
            delegate?.didNotSucceed()
        }
    }
    
    // print("Changing punch #\(x)")
    
    func delete()
    {
        if let removed = program.popLast() as? Int
        {
            if var matchingPunch = punches.first(where: { $0.punchValue == removed })
            {
                matchingPunch.selected = false
                delegate?.printToLabel(text: displayableProgram)
                delegate?.didUpdatePunch(punch: matchingPunch)
            }
        }
    }
    
    func updateScreen()
    {
        delegate?.printToLabel(text: displayableProgram)
    }

    typealias Operation = String
    typealias Operand   = Int

    func isSameTypeAsLastEntry(latest incoming : Any) -> Bool
    {
        guard let previous = program.last else { return false }

        switch (incoming, previous)
        {
            case (is Operand, is Operand)                                                                                : print("Operand, Operand")     ; return true
            case (let op1 as Operation, let op2 as Operation) where op1 != "(" && op1 != ")" && op2 != "(" && op2 != ")" : print("Operation, Operation") ; return true
            default                                                                                                      : print("Different types")      ; return false
        }
    }
    
    
    func sendPunchValueToScreen(index: Int)
    {
        if isSameTypeAsLastEntry(latest: punches[index].punchValue) { return }
        
        program.append(punches[index].punchValue)
        
        delegate?.printToLabel(text: displayableProgram)
        
        punches[index].selected = true // !punches[index].selected
        
        delegate?.didUpdatePunch(punch: punches[index])
    }
    
    
    func sendOperationToScreen(operation: String)
    {
        let proposedLabelText = labelText + operation
        
        print("Proposed text label:\(proposedLabelText)")

        if isSameTypeAsLastEntry(latest: operation) { return }

        program.append(operation)

        delegate?.printToLabel(text: displayableProgram)
    }
    
    
    func sendTargetBackDefeated()
    {
        delegate?.sendTargetBackDefeated()
    }
    
    
    func convertStringForEvaluation(_ someString: String) -> String
    {
        let startingString = someString
        print("\n startingString: \(startingString)")
        
        let secondString = startingString.replacingOccurrences(of: "^", with: "**")
        print("\n secondString: \(secondString)")
        
        let thirdString = secondString.replacingOccurrences(of: "x", with: "*")
        print("\n thirdString: \(thirdString)")
        
        return thirdString
    }
    
    func resetGame()
    {
        program.removeAll()

        tiles = (1...25).map {
            Tile(
                number    : $0,
                KOed      : false,
                operation : [Any](),
                attempts  : 0
            )
        }
//
//        tiles[0] = Tile(
//            number    : 1,
//            KOed      : false,
//            operation : [Any](),
//            attempts  : 0
//        )

        punches.removeAll()
    }

    func resetGameToBeKOedAllButOne()
    {
        program.removeAll()
        
        tiles = (1...25).map {
            Tile(
                number    : $0,
                KOed      : true,
                operation : [Any](),
                attempts  : 0
            )
        }
        
        tiles[0] = Tile(
            number    : 1,
            KOed      : false,
            operation : [Any](),
            attempts  : 0
        )
        
        punches.removeAll()
    }
    
    
    func printButtonStatusUpdate()
    {
        for x in 0..<punches.count
        {
            print("Punch #\(x + 1), Value \(punches[x].punchValue), Selected: \(punches[x].selected)")
        }
    }
    
    let inspirationalQuotes = [
        "\"It's not what you say out of your mouth that determines your life, it's what you whisper to yourself that has the most power.\" -- Robert T. Kiwosaki",
        "\"Train your mind to see the good in everything.\"",
        "\"When you make a mistake, it's not a enough to just correct it. You must correct it to the point that the party that has been wronged is happy that you made the mistake.\" -- Tim's Mom",
        "\"Rather than grind yourself into the ground, learn to pace yourself properly, so you have the staying power to get everything done.\"",
        "\"Yesterday I realized that the biggest thing standing between me and my dreams was waiting for other people to join me. Sorry, I'm not waiting anymore.\"",
        "\"The secret of getting things done is to act, not ask.\"",
        "\"Every accomplishment starts with the decision to try.\"",
        "\"Analysis Paralysis: With enough reflection, even the most straight forward problem can be turned into an unsolvable conundrum.\"",
        "\"If it is important to you, you will find a way.  If not, you'll find an excuse.\"",
        "\"If I had six hours to chop down a tree. I'd spend the first four hours sharpening the axe.\" -- Abe Lincoln",
        "\"The greater danger for most of us lies not in setting our aim too high and falling short; but in setting our aim too low, and achieving our mark.\" -- Michaelangelo",
        "\"Messy bun and getting stuff done.\"",
        "\"The difference between try and triumph is a little umph.\" ― Marvin Phillips",
        "\"It's not what you say out of your mouth that determines your life, it's what you whisper to yourself that has the most power.\" -- Robert T. Kiwosaki",
        "\"Judging yourself, is not the same as being honest with yourself.\"",
        "\"You have to be at your strongest when you're feeling at your weakest.\"",
        "\"Growth is painful.  Change is painful.  But nothing is as painful as staying stuck somewhere you don't belong.\"",
        "\"Don't wait until you reach your goal to be proud of yourself.  Be proud of each step you take toward reaching that goal.\"",
        "\"Sometimes we don't need advice.  We just need someone to listen.\"",
        "\"If you don't love yourself, you cannot love others. You will not be able to love others. If you have no compassion for yourself then you are not capable of developing compassion for others.\" -Dalai Lama",
        "\"Anyone can be cool, but awesome takes practice.\" - Lorraine Peterson",
        "\"No, this is not the beginning of a new chapter in my life; this is the beginning of a new book! That first book is already closed, ended, and tossed into the seas; this new book is newly opened, has just begun! Look, it is the first page! And it is a beautiful one!\" ― C. JoyBell C.",
        "\"No one succeeds without effort... Those who succeed owe their success to perseverance.\" Ramana Maharshi",
        "\"Communication is a skill that you can learn. It's like riding a bicycle or typing. If you're willing to work at it, you can rapidly improve the quality of every part of your life.\" Brian Tracy",
        "\"A well-organized life finds time for everything.  Always settle in advance that which you have set for yourself.\"",
        "\"Either you run the day or the day runs you.\" Jim Rohn",
        "\"Good habits are as addictive as bad habits, but much more rewarding.\"",
        "\"I AM: two of the most powerful words, for what you put after them shapes your reality.\""
        
    ]
    
    func randomInspirationalQuote() -> String
    {
        let randomInt = Int(arc4random_uniform(UInt32(inspirationalQuotes.count)))
        return inspirationalQuotes[randomInt]
        
    }
    
    // initialize
    func storeGameCombinationToMemory()
    {
        let games = (0..<gameCombinations.count).map {
            GameCombo(
                gameNumber : $0,
                gameCombo: gameCombinations[$0],
                won : false,
                dateWon  : ""
            )
        }
    
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data  = try? encoder.encode(games)

        UserDefaults.standard.set(data, forKey:"gameCombinations")
//
//        let gamesDecoded = UserDefaults.standard.object(forKey: "gameCombinations") as! Data
//
//        let decoder = JSONDecoder()
//        let products = try? decoder.decode([GameCombo].self, from: gamesDecoded)
        //// UserDefaults.standard.dictionaryRepresentation().map{print("'\($0.key)': '\($0.value)',")}
        
        getCurrentGameCombination()
        
    }
    
    func getCurrentGameCombination() -> String{
        var currentGameCombo = ""
        let punches = UserDefaults.standard.array(forKey: "selectedPunches") as! [Int]
        
        // determine gameCombo
        for punch in punches {
            currentGameCombo += String(punch)
        }
        
        setGameCombinationToWin(currentGameCombo)
        return currentGameCombo
    }
    
    func setGameCombinationToWin(_ currentGameCombo: String){
     
        var gameCombosDecoded = getArrayOfGamesPlayedFromUserDefaults()
        
        // update the appropriate gameCombo won status to true
        for (index, gameCombo) in gameCombosDecoded.enumerated() {
            if(gameCombo.gameCombo == currentGameCombo){
               //
                gameCombosDecoded[index].won = true
            }
        }
        
        // save the the back into userDefaults
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data  = try? encoder.encode(gameCombosDecoded)
        
        UserDefaults.standard.set(data, forKey:"gameCombinations")
        getPunchesForNextIncompleteGame()
    }
    
    func getPunchesForNextIncompleteGame() -> SelectedPunches {
        let gameCombosDecoded = getArrayOfGamesPlayedFromUserDefaults()
        var nextGameCombo = [Int]()
        
        // get an array of smallest incomplete game from UserDefaults
        for (index, _) in gameCombosDecoded.enumerated() {
            if(gameCombosDecoded[index].won == false){
//           for char in gameCombosDecoded[index]{
                nextGameCombo = gameCombosDecoded[index].gameCombo.map{ $0.wholeNumberValue! }
                break
//                }
            }
        }
        
       
        // reset game, based off of ChooseFourInterfaceController-> nextButtonTapped()
        resetGame()
        punches = [
            Punch(num: 0, punchValue: nextGameCombo[0]),
            Punch(num: 1, punchValue: nextGameCombo[1]),
            Punch(num: 2, punchValue: nextGameCombo[2]),
            Punch(num: 3, punchValue: nextGameCombo[3]),
        ]
        
        var selectedPunches = SelectedPunches()
        
        selectedPunches.first = nextGameCombo[0]
        selectedPunches.second = nextGameCombo[1]
        selectedPunches.third = nextGameCombo[2]
        selectedPunches.fourth = nextGameCombo[3]
        
        // set current punches to match nextGameCombo
        updateCurrentPunches(punchVals: nextGameCombo)
        // send to screen with punches filled out
        
        return selectedPunches
    }
    
    
    func getArrayOfGamesPlayedFromUserDefaults() -> [GameCombo]{
        // get gameCombos from UserDefaults
        let gamesCombos = UserDefaults.standard.object(forKey: "gameCombinations") as! Data
        
        // decode the data
        let decoder = JSONDecoder()
        let gameCombosDecoded = (try? decoder.decode([GameCombo].self, from: gamesCombos))!
     
        return gameCombosDecoded
    }
    
    func updateCurrentPunches( punchVals: [Int]){
        UserDefaults.standard.set(punchVals, forKey:"selectedPunches")
    }
    
}
