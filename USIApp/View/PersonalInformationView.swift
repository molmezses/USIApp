//
//  PersonalInformationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import SwiftUI

struct PersonalInformationView: View {
    
    @State var backButton : Bool = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .padding(.leading)
                        .onTapGesture {
                            backButton = true
                        }
                    Spacer()
                    Text("Kişisel bilgiler")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .padding(.leading)
                        .foregroundStyle(.white)

                }
                
                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                }
            }
            .navigationDestination(isPresented: $backButton) {
                ProfileView(navPage: .bos)
                    .navigationBarBackButtonHidden()
            }
        }
        
    }
}

#Preview {
    PersonalInformationView()
}
