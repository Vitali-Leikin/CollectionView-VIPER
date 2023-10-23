//
//  ListPresenter.swift
//  CollectionViewAdvertVIPER
//
//  Created by vitali on 20.10.2023.
//

import Foundation

class ListPresenter: ListViewOutputProtocol{
    
    unowned let view: ListViewInputProtocol
    var interactor: ListInteractorInputProtocol!
    
    required init(view: ListViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchCourse()
    }
    
    func didTappedEggsButton() {
        interactor.startCreateAllert()
    }
    func didSelectCellTapped(at indexPath: IndexPath) {
        interactor.didSelectTapped(at: indexPath)
    }
    
    
}

// MARK: - extension ListPresenter: ListInteractorOutputProtocol

extension ListPresenter: ListInteractorOutputProtocol{
    func sortedAdverts(list: [List]) {
        let section = AdvertSectionViewModel()
        list.forEach { section.rows.append(AdvertCellViewModel(model: $0))}
        view.registerCell(id: section.rows.first?.cellIdentifier ?? "")
        view.reloadData(for: section)
    }
    
    func advertDidReceive(_ advert: Adverts) {
        view.displayTitle(title: advert.result.title)
        view.displayButtonTitle(title: advert.result.selectedActionTitle)
    }
    
    func createAllert(title: String, message: String) {
        view.showAlert(title: title, message: message)
    }
    
    
}
