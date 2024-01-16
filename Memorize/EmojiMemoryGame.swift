//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 李某某 on 22/12/23.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject{
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["👻", "🎃", "🤡", "💩", "👺", "😺", "😈", "😽", "👾", "🧑‍✈️", "🧚‍♀️", "🧜‍♂️", "🧥", "👚", "👘", "🐶"]
    
    private static func creatMemoryGame() -> MemoryGame<String>{
        return MemoryGame(numberOfPairsOfCardds: 2) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            }
            else{
                return "‼️"
            }
        }
    }
    
    @Published private var MemoryGameModel = creatMemoryGame()
    
    var cards: Array<Card>{
        return MemoryGameModel.cards
    }
    
    var memoryCardColor: Color{
        return .orange
    }
    
    // MARK : - Intents
    func shuffle(){
        MemoryGameModel.shuffle()
    }
    
    func choose(_ card: Card){
        MemoryGameModel.choose(card)
    }
}
