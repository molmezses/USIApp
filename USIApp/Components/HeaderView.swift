//
//  HeaderView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        // Header Bölümü
        HStack(alignment: .center) {
            Image("ünilogo")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            Spacer()
            
            VStack(spacing: 4) {
                HStack {
                    Text("USİ")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Spacer()
                }
                HStack {
                    Text("Üniversite - Sanayi İşbirliği")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.8))
                    Spacer()
                }
            }
            .padding(.leading)
            
            Spacer()
            
            
        }
        .padding()
        .background(Color("usi"))
        .padding(.top, 40)
    }
}

#Preview {
    HeaderView()
}
