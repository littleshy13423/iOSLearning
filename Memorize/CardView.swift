//
//  CardView.swift
//  Memorize
//
//  Created by 李某某 on 3/1/24.
//

import SwiftUI

struct CardView: View {
    typealias tpCard = MemoryGame<String>.Card
    
    let card: tpCard
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    private struct Constants{
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize{
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest/largest
        }
        struct Pie{
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 5
        }
    }
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            )
            .padding(Constants.inset)
            .cardify(isFacedUp: card.isFacedUp)
            .opacity(card.isFacedUp || !card.isMatched ? 1:0)
    }
}

struct CardView_Previews: PreviewProvider {
    typealias tpCardinPreview = CardView.tpCard
    static var previews: some View {
        VStack{
            HStack{
                CardView(tpCardinPreview(isFacedUp: true, content: "X", id: "test1"))
                CardView(tpCardinPreview(content: "This is a very long string and i hope it fits", id: "test1"))
            }
            HStack{
                CardView(tpCardinPreview(isFacedUp: true, isMatched: true, content: "This is a very long string and i hope it fits", id: "test1"))
                CardView(tpCardinPreview(isMatched: true, content: "X", id: "test1"))
            }
        }
        .padding()
    }
}
