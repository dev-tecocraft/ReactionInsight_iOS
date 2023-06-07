//
//  PostDataView.swift
//  ReactionInsight
//
//  Created by iMac
//

import SwiftUI

struct PostDataView: View {
    
    var body: some View {
        HStack(spacing: 12) {
            
            Image(Img.profile)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(LabelText.userName)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                Text(LabelText.city)
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
            }
            
            Spacer()
        }
        .padding([.leading, .top])
        .padding(.bottom, 4)
        
        Image(Img.analysis)
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width - 50, height: 150)
            .cornerRadius(8)
    }
}
