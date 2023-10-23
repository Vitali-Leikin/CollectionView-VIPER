//
//  CustomCell.swift
//  CollectionViewAdvertVIPER
//
//  Created by vitali on 20.10.2023.
//

import UIKit


protocol CellModelRepresentable {
    var viewModel: CellIdentifiable? { get set }
}

class CustomCell: UICollectionViewCell, CellModelRepresentable {
    
    // MARK: - property
    private let positionX = 0
    private let positionY = 10
    private let stepPosition = 10
    private let sizeImageIcon = 52
    
    // MARK: - calculate UI property

    private lazy var viewLeftImage: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.frame.width / 4, height: self.frame.height)
        return view
    }()

    private lazy var viewCenter: UIView  = {
        let view = UIView()
        view.frame = CGRect(x: viewLeftImage.bounds.width, y: 0, width: self.frame.width / 2, height: self.frame.height)
        return view
    }()

    private lazy var viewRight: UIView = {
        let view = UIView()
        view.frame = CGRect(x: viewCenter.frame.width + viewLeftImage.frame.width, y: 0, width: self.frame.width / 4, height: self.frame.height)
        return view
    }()

    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.frame = CGRect(x: positionX, y: positionY,
                             width: Int(viewCenter.bounds.width) - positionX,
                             height: Int(viewCenter.bounds.height) / 4
        )
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private lazy var labelDescription: UILabel =  {
        let label = UILabel()
        label.frame = CGRect(x: positionX,
                             y: Int(labelTitle.bounds.height),
                             width: Int(viewCenter.bounds.width),
                             height: Int(viewCenter.bounds.height) / 2
        )
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    private lazy var labelPrice: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.frame = CGRect(x: positionX,
                             y: Int(labelDescription.bounds.height + labelTitle.bounds.height) ,
                             width: Int(viewCenter.bounds.width) - positionX,
                             height: Int(viewCenter.bounds.height) / 4
        )
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private  lazy var imageIcon: UIImageView = {
        let img = UIImageView()
        img.frame = CGRect(x: Int(viewLeftImage.bounds.width / 2) - sizeImageIcon / 2 , y: positionY, width: 52, height: 52)
        img.image = UIImage(systemName: "xmark.octagon.fill")
        return img
    }()

    private lazy var imageChoose: UIImageView = {
        let img = UIImageView()
        img.frame = CGRect(x: Int(viewRight.bounds.width / 2) - 30 / 2 , y: positionY + (sizeImageIcon / 2) - 30 / 2, width: 30, height: 30)
        img.image = UIImage(systemName: "checkmark.circle.fill")
        img.tintColor = .tintColor
        return img
    }()
    
    var viewModel: CellIdentifiable? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Func UI
    func updateViews() {
        
     guard let cellViewModel = viewModel as? AdvertCellViewModel else { return }
        self.backgroundColor = .systemGray4
        labelDescription.text = cellViewModel.description
        labelPrice.text = cellViewModel.price
        labelTitle.text = cellViewModel.title
        imageIcon.load(url: cellViewModel.imageURL)
        
        self.sizeToFit()
        self.backgroundColor = .systemGray6
        self.addSubview(viewLeftImage)
        self.addSubview(viewCenter)
        self.addSubview(viewRight)
        self.layer.cornerRadius = 10

        viewCenter.addSubview(labelTitle)
        viewCenter.addSubview(labelDescription)
        viewCenter.addSubview(labelPrice)
        viewLeftImage.addSubview(imageIcon)
        viewRight.addSubview(imageChoose)
        
        if cellViewModel.isSelected{
            imageChoose.isHidden = false
        }else{
            imageChoose.isHidden = true
        }
    }
}


