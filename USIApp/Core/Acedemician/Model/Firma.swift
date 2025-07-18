//
//  Firma.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 16.07.2025.
//

import Foundation

struct Firma: Codable, Equatable {
    var id: String = UUID().uuidString
    var firmaAdi: String
    var firmaCalismaAlani: [String]

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "firmaAdi": firmaAdi,
            "firmaCalismaAlani": firmaCalismaAlani
        ]
    }
}


