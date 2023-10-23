//
//  ViewController.swift
//  CollectionViewAdvertVIPER
//
//  Created by vitali on 20.10.2023.
//

import UIKit

protocol ListViewInputProtocol: AnyObject{
    func displayTitle(title: String)
    func showAlert(title: String, message: String)
    func displayButtonTitle(title: String)
    func reloadData(for section: AdvertSectionViewModel)
    func registerCell(id: String)
}

protocol ListViewOutputProtocol{
    init(view: ListViewInputProtocol)
    func viewDidLoad()
    func didTappedEggsButton()
    func didSelectCellTapped(at indexPath: IndexPath)
}

class ListViewController: UIViewController {

    // MARK: - property
    private let sizeCancelBtn = 20
    private let positionX = 20
    private let spaceStep = 20
    private let corner: CGFloat = 10
    private let heightTitleLabel = 70
    private let sizeTitleText: CGFloat = 30
    private let heightCVCell = 200
    private var heightButton = 60
    
    var presenter: ListViewOutputProtocol!
    private let configurator: ListConfigurator = ListConfigurator()
    private var section: SectionRowPresentable = AdvertSectionViewModel()
    private var chosenService: String?
    
    // MARK: - calculate UI property
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: positionX, y: positionX + spaceStep, width: sizeCancelBtn, height: sizeCancelBtn)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: positionX,
                             y: Int(closeButton.frame.origin.y + closeButton.frame.height) + spaceStep,
                             width: Int(view.bounds.width) - positionX * 2,
                             height: heightTitleLabel
        )
        label.font = UIFont.boldSystemFont(ofSize: sizeTitleText)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: Int(view.bounds.width) - positionX * 2, height: heightCVCell)
        layout.minimumInteritemSpacing = CGFloat(spaceStep)
        layout.minimumLineSpacing = CGFloat(spaceStep)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame:
                                    CGRect(x: positionX,
                                           y: Int(mainLabel.bounds.height + mainLabel.bounds.height) + spaceStep,
                                           width: Int(view.bounds.width) - positionX * 2,
                                           height: Int(view.bounds.height - CGFloat((heightTitleLabel + heightCVCell)))),
                                  collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    
    private lazy var chooseButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: positionX,
                              y: Int((collectionView.frame.origin.y) + (collectionView.bounds.height) ) + spaceStep,
                              width: Int(view.bounds.width) - positionX * 2,
                              height: heightButton)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .tintColor
        button.layer.cornerRadius = corner
        return button
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupUI()
    }

    // MARK: - Func UI
    
    private func setupUI(){
        closeButton.isEnabled = false
        self.view.addSubview(closeButton)
        self.view.addSubview(mainLabel)
        self.view.addSubview(chooseButton)
        view.addSubview(collectionView)
        chooseButton.addTarget( self, action: #selector(buttonTapped) , for: .touchUpInside)
    }
    
    // MARK: - Func @objc
    @objc private func buttonTapped(){
        presenter.didTappedEggsButton()
    }
}

// MARK: - extension ListViewController: ListViewInputProtocol

extension ListViewController: ListViewInputProtocol{
    func registerCell(id: String) {
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: id)
    }
    
    func reloadData(for section: AdvertSectionViewModel) {
        self.section = section
        collectionView.reloadData()
    }
    
    func displayButtonTitle(title: String) {
        chooseButton.setTitle(title, for: .normal)
    }
    
    func displayTitle(title: String) {
        mainLabel.text = title
        mainLabel.sizeToFit()
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "OK", style: .default)
        alert.addAction(actionAlert)
        self.present(alert, animated: true, completion: nil)
    }
}


// MARK: - extension ListViewController: UICollectionViewDelegate UICollectionViewDataSource

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       self.section.rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = section.rows[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.cellIdentifier, for: indexPath) as! CustomCell
        cell.viewModel = cellModel
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCellTapped(at: indexPath)
    }
}
