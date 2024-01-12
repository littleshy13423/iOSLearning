//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 李某某 on 22/12/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCardds: Int, cardContentFactory:(Int) -> CardContent){
        cards = []
        //add number of pairs of cards x 2 cards
        for pairIndex in 0..<numberOfPairsOfCardds{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOftheOneAndOnlyFacedUpCard: Int?{
        get{
            return cards.indices.filter{ index in cards[index].isFacedUp }.only
        }
        set{
            return cards.indices.forEach{cards[$0].isFacedUp = (newValue == $0)}
        }
    }
    
    mutating func choose(_ card: Card){
        print("chose \(card)")
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            if !cards[chosenIndex].isFacedUp && !cards[chosenIndex].isMatched{
                if let potentialMatchIndex = indexOftheOneAndOnlyFacedUpCard{
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                }else{
                    indexOftheOneAndOnlyFacedUpCard = chosenIndex
                }
                cards[chosenIndex].isFacedUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
        
        static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.isFacedUp == rhs.isFacedUp &&
            lhs.isMatched == rhs.isMatched &&
            lhs.content == rhs.content
        }
        
        var isFacedUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
        
        var debugDescription: String{
            "\(id): \(content) \(isFacedUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}

extension Array{
    var only: Element?{
        return count == 1 ? first : nil
    }
}
