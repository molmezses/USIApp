//
//  FooterView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        // Footer Logoları
        HStack(spacing: 20) {
            ForEach(["ünilogo", "valilik", "kosgeb", "stb"], id: \.self) { logo in
                Image(logo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("usi"))
    }
}

#Preview {
    FooterView()
}
