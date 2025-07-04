//
//  SecureFieldWithButton.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 4.07.2025.
//



import SwiftUI

struct SecureFieldWithButton: View {
    
    @Binding private var text: String
    @State private var isSecured : Bool = false
    private var title : String
    
    init(title: String , text : Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment:.trailing){
            Group{
                if isSecured {
                    SecureField(title, text: $text)
                }else{
                    TextField(title, text: $text)
                }
            }
            Button{
                isSecured.toggle()
            }label: {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .tint(.gray)
            }
        }
    }
}


    #Preview {
        SecureFieldWithButton(title: "Password", text: .constant(""))
    }
