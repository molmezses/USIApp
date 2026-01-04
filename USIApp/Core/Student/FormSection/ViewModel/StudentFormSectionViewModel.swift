//
//  StudentFormSectionViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 6.10.2025.
//

import Foundation
import FirebaseAuth
enum StudentFormsEnum {
    case studentName
    case studentSurname
    case studentPhone
    case universityName
    case departmentName
    case classNumber
}


class StudenFormSectionViewModel: ObservableObject {
    
    @Published  var studentName = ""
    @Published var studentSurname = ""
    @Published var studentPhone = ""
    @Published var errorMessage = "" {
            didSet {
                showAlert = !errorMessage.isEmpty
            }
        }
    @Published var showAlert = false
    @Published var universityName: String = ""
    @Published var departmentName: String = ""
    @Published  var classNumber: String = "1. Sınıf"

    

    
    init() {
        self.loadStudentProfileData()
    }
    
    func saveStudentUniversityName(){
        guard !universityName.isEmpty else {
            errorMessage = "Lütfen üniversitenizi seçiniz"
            return
        }
        
        let universityData: [String : Any] = ["universityName" : universityName]
        
        StudentFirestoreService.shared.saveStudentData(studentData: universityData) { error in
            if let error = error{
                self.errorMessage = error.localizedDescription
            }else{
                print("Veriler başarıyla güncellendi -> StudentFirmInformation")
                self.errorMessage = ""
            }
        }
    }
    
    
    func saveStudentProfileData() {
        
        guard !studentName.isEmpty && !studentSurname.isEmpty && !studentPhone.isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun"
            return
        }
        
        let studentData: [String : Any] = [
            "studentName" : studentName + " " + studentSurname,
            "studentPhone" : studentPhone,
            "universityName" : universityName,
            "classNumber" : classNumber,
            "departmentName" : departmentName
        ]
        
        StudentFirestoreService.shared.saveStudentData(studentData: studentData) { error in
            if let error = error{
                self.errorMessage = error.localizedDescription
            }else{
                print("Veriler başarıyla güncellendi -> StudentFirmInformation")
                self.errorMessage = ""
            }
        }

    }
    
    func loadStudentProfileData() {
        StudentFirestoreService.shared.fetchStudentProfileData { [weak self] result in
            switch result {
            case .success(let info):
                
                let nameResult = self?.splitName(info.studentName)
                
                
                self?.studentName = nameResult?.firstName ?? ""
                self?.studentSurname = nameResult?.lastName ?? ""
                self?.studentPhone = info.studentPhone
                self?.universityName = self?.fetchUniversityName(firebaseEmail: info.universityName) ?? ""
                self?.classNumber = info.classNumber
                self?.departmentName = info.departmentName
                print("Başrılı : loadStudentProfileData -> veriler çekildi")
                self?.errorMessage = ""
            case .failure(let failure):
                self?.errorMessage = failure.localizedDescription
                print("Hata : loadStudentProfileData ->  \(failure.localizedDescription)")
            }
        }
    }
    
    func splitName(_ fullName: String) -> (firstName: String, lastName: String) {
        
        let trimmed = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let lastSpaceIndex = trimmed.lastIndex(of: " ") else {
            return (firstName: trimmed, lastName: "")
        }
        
        let lastName = String(trimmed[trimmed.index(after: lastSpaceIndex)...])
        let firstName = String(trimmed[..<lastSpaceIndex])
        
        return (firstName, lastName)
    }


    func fetchUniversityName(firebaseEmail : String) -> String {
        
        if firebaseEmail == "" {
            if self.getEmailDomain(from: Auth.auth().currentUser?.email ?? "") == "ogr.ahievran.edu.tr"{
                return "Ahi Evran Üniversitesi"
            }
        }else{
            return firebaseEmail
        }
        
        return "Bulunamadı"

    }
    
    func getEmailDomain(from email: String) -> String {
        let parts = email.split(separator: "@")
        
        if parts.count == 2 {
            return String(parts[1])
        } else {
            return ""
        }
    }


}







