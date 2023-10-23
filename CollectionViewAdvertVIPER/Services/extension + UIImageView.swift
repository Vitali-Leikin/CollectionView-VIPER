//
//  extension + UIImageView.swift
//  CollectionViewAdvertVIPER
//
//  Created by vitali on 23.10.2023.
//

import UIKit

// MARK: - extension Load UIImageView

extension UIImageView {
    func load(url: String) {
        guard let url = URL(string: url) else{fatalError()}
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
