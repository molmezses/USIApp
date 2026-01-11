//
//  SplashView.swift
//  USIApp
//
//  Created by mustafaolmezses on 5.01.2026.
//


import SwiftUI

struct SplashView: View {

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            Image("launch")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
        }
    }
}

