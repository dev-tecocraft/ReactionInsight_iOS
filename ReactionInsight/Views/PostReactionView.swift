//
//  PostReactionView.swift
//  ReactionInsight
//
//  Created by iMac
//

import SwiftUI

struct PostReactionView: View {
    let action:()-> Void
    var reactionModel: ReactionModel
    var body: some View {
        
        VStack {
            Button(action: {
                action()
            }) {
                VStack {
                    Image(reactionModel.img)
                        .resizable()
                        .scaledToFit()
                        .frame(height:  50)
                    Text("\(reactionModel.numbers)")
                        .foregroundColor(.black)
                }
            }
        }
    }
}
