//
//  Cardify.swift
//  Memorize
//
//  Created by 李某某 on 12/1/24.
//

import SwiftUI

struct Cardify: ViewModifier{
    let isFacedUp: Bool
    func body(content: Content )-> some View{
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFacedUp ? 1:0)
            base.fill()
                .opacity(isFacedUp ? 0:1)
        }
    }
    private struct Constants{
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View{
    func cardify(isFacedUp: Bool) -> some View{
        modifier(Cardify(isFacedUp: isFacedUp))
    }
}
