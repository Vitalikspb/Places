//
//  CountryPhotosTableViewCell.swift
//  TabBarTest
//
//

import UIKit

class CountryToSelectTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.init(name: "GillSans-Semibold", size: 20)
        return label
    }()
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    let gradientView = GradientView()

    // MARK: - Public properties
    
    static let identifier = "CountryToSelectTableViewCell"

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
        // Для обрезания длинного текста описания события
        self.clipsToBounds = true
        let bgColorView = UIView()
        bgColorView.backgroundColor = .white
        self.selectedBackgroundView = bgColorView
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-32, height: 50),
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        gradientView.colors = [UIColor.clear, UIColor.black]
        gradientView.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientView.layer.mask = maskLayer
        
        self.backgroundColor = .white
        
        
        contentView.addSubview(mainImageView)
        contentView.addSubview(gradientView)
        contentView.addSubview(titleLabel)
        
        titleLabel.anchor(top: nil,
                          left: contentView.leftAnchor,
                          bottom: mainImageView.bottomAnchor,
                          right: contentView.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0,
                          height: 50)
        mainImageView.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             bottom: contentView.bottomAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 16,
                             paddingLeft: 16,
                             paddingBottom: 16,
                             paddingRight: 16,
                             width: 0, height: 0)
        gradientView.anchor(top: nil,
                            left: mainImageView.leftAnchor,
                            bottom: mainImageView.bottomAnchor,
                            right: mainImageView.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0, height: 50)
    }

    func configureCell(title: String, image: UIImage) {
        titleLabel.text = title
        mainImageView.image = image
    }
}
