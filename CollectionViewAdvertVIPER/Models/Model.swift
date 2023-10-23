//
//  Model.swift
//  CollectionViewAdvertVIPER
//
//  Created by vitali on 20.10.2023.
//

import Foundation

// MARK: - Adverts
struct Adverts: Codable {
    let status: String
    var result: Result
}

// MARK: - Result
struct Result: Codable {
    let title, actionTitle, selectedActionTitle: String
    var list: [List]
}

// MARK: - List
struct List: Codable {
    let id, title: String
    let description: String?
    let icon: Icon
    let price: String
    var isSelected: Bool
}

// MARK: - Icon
struct Icon: Codable {
    let urlIcon: String

    enum CodingKeys: String, CodingKey {
        case urlIcon = "52x52"
    }
}
