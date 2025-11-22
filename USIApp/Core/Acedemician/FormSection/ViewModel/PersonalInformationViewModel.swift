//
//  PersonalInformationViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 11.07.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth



enum PersonalInformationEnum{
    case name
    case surname
}

class PersonalInformationViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var surName: String = ""
    @Published var unvan: String = ""
    @Published var showTitleSheet: Bool = false
    @Published var unvanList = ["Prof.  Dr.", "Dr.", "Doç.  Dr.", "Arş.  Gör.", "Öğr.  Gör."]
    @Published var academicianInfo: AcademicianInfo?
    
    
    
    
    
    func loadPersonelInformation(){
       
        if let userId = Auth.auth().currentUser?.uid{
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                
                switch result {
                case .success(let info):
                    
                    let nameSurname = info.adSoyad
                    let  reversed = String(nameSurname.reversed())
                    
                    let components = reversed.components(separatedBy: " ")
                    let firstPart = components.first ?? ""
                    let remainingPart = components.dropFirst().joined(separator: " ")
                    
                    let surName = String(firstPart.reversed())
                    let name = String(remainingPart.reversed())
                    
                    self.name = name
                    self.surName = surName
                    
                    self.unvan = self.unvanFormat(unvan: info.unvan)
                    self.academicianInfo = info
                    
                    
                case .failure(let error):
                    print("Hata loadAcademicianInfo : \(error.localizedDescription)")
                }
                
            }
        }
        
    }
    
    func unvanFormat(unvan: String) -> String{
        let exUnvan = unvan
        
        switch exUnvan {
        case "Prof.  Dr.":
            let newUnvan = "Profesör"
            return newUnvan
        case "Dr.":
            let newUnvan = "Doktor"
            return newUnvan
        case "Doç.  Dr.":
            let newUnvan = "Doçent"
            return newUnvan
        case "Arş.  Gör.":
            let newUnvan = "Araştırma Görevlisi"
            return newUnvan
        case "Öğr.  Gör.":
            let newUnvan = "Öğretim Görevlisi"
            return newUnvan
        default:
            let newUnvan = "yok"
            return newUnvan
        }
    }
    
    func updateUnvan(){
        let db = Firestore.firestore()
        
        if let userId = Auth.auth().currentUser?.uid{
            let docRef = db.collection("Academician").document(userId)
            docRef.updateData(["unvan" : self.unvan]){ error in
                if let error = error{
                    print("HATA: \(error.localizedDescription)")
                }else{
                    print("Başarılı")
                }
            }
        }

        
                
                
                
            
    }
    
    
}
