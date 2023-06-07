//
//  BgViewModifier.swift
//  ReactionInsight
//
//  Created by iMac
//

import SwiftUI

struct BgView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 1)
            )
            .shadow(radius: 5)
            .padding(.all)
    }
}
