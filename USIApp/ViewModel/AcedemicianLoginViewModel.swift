//
//  AcedemicianLoginViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import Foundation

class AcedemicianLoginViewModel: ObservableObject {
    
    @Published var sicil: String = ""
    @Published var errorMessage : String = "empty"
    
    func sicilValidate() -> Bool {
        if sicil.count == 5 {
            errorMessage = "Sicil numarası doğru"
            return true
        }else{
            errorMessage = "Lütfen geçerli bir sicil numarası giriniz"
            return false
        }
    }
    
    
}
