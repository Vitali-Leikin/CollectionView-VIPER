//
//  ListConfigurator.swift
//  CollectionViewAdvertVIPER
//
//  Created by vitali on 20.10.2023.
//

import Foundation


protocol ListConfiguratorInputProtocol{
    func configure(with view: ListViewController)
}


class ListConfigurator: ListConfiguratorInputProtocol{
    func configure(with view: ListViewController) {
        let presenter = ListPresenter(view: view)
        let interactor = ListInteractor(presenter: presenter)
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
