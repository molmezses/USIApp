//
//  StudentPreviewViewModel.swift
//  USIApp
//
//  Created by mustafaolmezses on 8.12.2025.
//



import Foundation
import FirebaseAuth

class StudentPreviewViewModel: ObservableObject{
    
    @Published var classNumber : String = ""
    @Published var departmentName : String = ""
    @Published var studentEmail : String = ""
    @Published var studentImage : String = ""
    @Published var studentName : String = ""
    @Published var studentPhone : String = ""
    @Published var universityName : String = ""
    
    func loadStudentPreviewData(id: String){
        
        if (Auth.auth().currentUser?.uid) != nil{
            
            StudentFirestoreService.shared.fetchStudentInfo(byId: id) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let info):
                        
                        self.classNumber = info.classNumber
                        self.departmentName = info.departmentName
                        self.studentEmail = info.studentEmail
                        self.studentImage = info.studentImage
                        self.studentName = info.studentName
                        self.studentPhone = info.studentPhone
                        self.universityName = info.universityName
                        
                    case .failure(let failure):
                        print("Hata : loadStudentPreviewData : \(failure.localizedDescription)")
                    }
                }
            }
            
        }
        
    }
    
    
}
