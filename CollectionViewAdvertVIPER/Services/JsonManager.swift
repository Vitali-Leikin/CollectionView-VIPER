//
//  JsonManager.swift
//  CollectionViewAdvertVIPER
//
//  Created by vitali on 20.10.2023.
//

import Foundation

enum K: String{
    case dataJSON = "dataJSON"
    case jsonExten = "json"
}


class JSONManager{
    static let shared = JSONManager()
    func loadJson() -> Adverts? {
        if let url = Bundle.main.url(forResource: K.dataJSON.rawValue, withExtension: K.jsonExten.rawValue) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Adverts.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    
}

