//
//  RequestModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 21.07.2025.
//

import Foundation

struct RequestModel: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var date: Date
}
