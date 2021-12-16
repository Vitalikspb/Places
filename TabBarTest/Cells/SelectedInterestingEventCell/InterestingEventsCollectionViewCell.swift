//
//  CountryCellsCitiesCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit


class InterestingEventsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    // MARK: - Public properties
    
    static let identifier = "InterestingEventsCollectionViewCell"
    var cellImage: UIImage = UIImage() {
        didSet {
            mainImageView.image = cellImage
        }
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        
        // TODO
//        let path = UIBezierPath(roundedRect: CGRect(x: 0,
//                                                    y: 0,
//                                                    width: contentView.frame.width,
//                                                    height: 50),
//                                byRoundingCorners: [.bottomLeft, .bottomRight],
//                                cornerRadii: CGSize(width: 8, height: 8))
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
        backgroundColor = .white
        layer.cornerRadius = 8
        standartShadow(view: self)
        
        contentView.addSubview(mainImageView)
        
        mainImageView.addConstraintsToFillView(view: contentView)
    }
    
    func conigureCell(image: UIImage) {
        cellImage = image
    }

}

