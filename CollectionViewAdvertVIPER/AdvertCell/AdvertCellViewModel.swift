//
//  AdvertCellViewModel.swift
//  CollectionViewAdvertVIPER
//
//  Created by vitali on 20.10.2023.
//

import Foundation



protocol CellIdentifiable {
    var cellIdentifier: String { get }
    var cellHeight: Double { get }
}

protocol SectionRowPresentable {
    var rows: [CellIdentifiable] { get set }
}

class AdvertCellViewModel: CellIdentifiable {
    let description: String
    let imageURL: String
    let title: String
    let price: String
    let isSelected: Bool
    
    var cellIdentifier: String {
        "CourseCell"
    }
    
    var cellHeight: Double {
        200
    }
    
    init(model: List) {
        description = model.description ?? "hren"
        title = model.title
        price = model.price
        imageURL = model.icon.urlIcon
        isSelected = model.isSelected
    }
}

class AdvertSectionViewModel: SectionRowPresentable {
    var rows: [CellIdentifiable] = []
}
