//
//  ReactionPercentageView.swift
//  ReactionInsight
//
//  Created by iMac.
//

import SwiftUI

struct ReactionPercentageView: View {
    
    var img: String
    var txt: String
    var color: Color
    
    var body: some View {
        
        HStack {
            Image(img)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            Text(txt)
                .font(.system(size: 14))
                .frame(width: 60)
            
            Rectangle()
                .fill(color)
                .frame(width: 15, height: 15)
            
            Spacer()
        }
    }
}

