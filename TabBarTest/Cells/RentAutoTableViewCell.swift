//
//  RentAutoTableViewCell.swift
//  TabBarTest
//
//

import UIKit

class RentAutoTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private let imageRentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private let nameRentLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.contentMode = .center
        title.textAlignment = .left
        title.backgroundColor = .clear
        title.font = UIFont.init(name: "GillSans-SemiBold", size: 16)
        return title
    }()
    private let arrowImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "gear")
        image.contentMode = .scaleAspectFit
        image.tintColor = .lightGray
        return image
    }()
    
    // MARK: - Public properties
    
    static let identifier = "RentAutoTableViewCell"
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        
        contentView.addSubview(imageRentImageView)
        contentView.addSubview(nameRentLabel)
        contentView.addSubview(arrowImageView)
        
        imageRentImageView.anchor(top: contentView.topAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: contentView.bottomAnchor,
                                  right: nameRentLabel.rightAnchor,
                                  paddingTop: 2,
                                  paddingLeft: 2,
                                  paddingBottom: 2,
                                  paddingRight: 16,
                                  width: 76, height: 76)
        nameRentLabel.anchor(top: contentView.topAnchor,
                             left: nil,
                             bottom: contentView.bottomAnchor,
                             right: arrowImageView.leftAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 32,
                             width: 0, height: 0)
        arrowImageView.anchor(top: contentView.topAnchor,
                              left: nil,
                              bottom: contentView.bottomAnchor,
                              right: contentView.rightAnchor,
                              paddingTop: 27,
                              paddingLeft: 0,
                              paddingBottom: 27,
                              paddingRight: 16,
                              width: 26, height: 26)
    }
    
    func configureCell(name: String, image: UIImage) {
        nameRentLabel.text = name
        imageRentImageView.image = image
    }
    
}

