//
//  ListInteractor.swift
//  CollectionViewAdvertVIPER
//
//  Created by vitali on 20.10.2023.
//

import Foundation


protocol ListInteractorInputProtocol{
    init(presenter: ListInteractorOutputProtocol)
    func startCreateAllert()
    func fetchCourse()
    func didSelectTapped(at indexPath: IndexPath )
}

protocol ListInteractorOutputProtocol: AnyObject{
    func createAllert(title:String, message: String)
    func advertDidReceive(_ advert: Adverts)
    func sortedAdverts(list: [List])
}

class ListInteractor: ListInteractorInputProtocol{
    var advert: Adverts?
    var model: [List] = []
    var chooseType: String?
    unowned let presenter: ListInteractorOutputProtocol
    
    required init(presenter: ListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func didSelectTapped(at indexPath: IndexPath) {
        for (index ,_) in model.enumerated(){
            model[index].isSelected = false
        }
        chooseType = model[indexPath.row].title
        model[indexPath.row].isSelected.toggle()
        presenter.sortedAdverts(list: model)
    }
    
    func fetchCourse() {
        advert = JSONManager.shared.loadJson()
        guard let safeAdvert = advert else {fatalError()}
        presenter.advertDidReceive(safeAdvert)
        
        for (_,item) in safeAdvert.result.list.enumerated(){
            if item.description != "" && item.description != nil{
                model.append(item)
            }
            for (index ,_) in model.enumerated(){
                model[index].isSelected = false
            }
            chooseType = model[0].title
            model[0].isSelected = true
        }
        presenter.sortedAdverts(list: model)
    }

    func startCreateAllert() {
        presenter.createAllert(title: "Вы выбрали:", message: chooseType ?? "z")
    }
    
    
}
