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
    }
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.inset)
            }
            .opacity(card.isFacedUp ? 1:0)
            base.fill()
                .opacity(card.isFacedUp ? 0:1)
        }
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
