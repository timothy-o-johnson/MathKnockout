//
//  GameEngine.swift
//  NoNotif
//
//  Created by John Grönlund on 21/01/2017.
//  Copyright © 2017 John Groenlund. All rights reserved.
//

import Foundation

#if os(iOS)
    import MathParser_iOS
#elseif os(watchOS)
    import MathParser_watchOS
#endif

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
        
        punches.removeAll()
    }
    
    
    func printButtonStatusUpdate()
    {
        for x in 0..<punches.count
        {
            print("Punch #\(x + 1), Value \(punches[x].punchValue), Selected: \(punches[x].selected)")
        }
    }
    
}
