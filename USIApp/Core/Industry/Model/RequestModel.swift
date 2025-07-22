//
//  RequestModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 21.07.2025.
//

import Foundation

struct RequestModel:Identifiable {
    var id :String
    var title: String
    var description: String
    var date: String
    var selectedCategories: [String]
    var status: RequestStatus
}
