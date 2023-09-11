//
//  CountryDescriptionTableViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol CountryDescriptionTableViewCellDelegate: AnyObject {
    func showMoreText()
    func heightCell(height: CGFloat)
}

class CountryDescriptionTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-bold", size: 22)
        label.text = Constants.Cells.cityDescription
        label.text = ""
        return label
    }()
    private let mainTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans-semibold", size: 16)
        label.text = ""
        return label
    }()
    private let gradientView = GradientView()
    
    let moreButtons: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        let yourAttributes: [NSAttributedString.Key: Any] = [
              .font: UIFont(name: "GillSans", size: 16) ?? UIFont.systemFont(ofSize: 16),
              .foregroundColor: UIColor(named: "titleText") ?? UIColor.black,
              .underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        let attributeString = NSMutableAttributedString(
                string: Constants.Cells.readMore,
                attributes: yourAttributes
             )
        button.setAttributedTitle(attributeString, for: .normal)
        return button
    }()
    // MARK: -  Public Properties
    
    static let identifier = "CountryDescriptionTableViewCell"
    weak var delegate: CountryDescriptionTableViewCellDelegate?
    
    // MARK: - LifeCycle
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
        self.backgroundColor = .clear
        self.clipsToBounds = true
        
        gradientView.colors = [.setCustomColor(color: .gradientBlack), .setCustomColor(color: .gradientWhite)]
        gradientView.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        moreButtons.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        contentView.addSubviews(titleLabel, mainTextLabel, gradientView, moreButtons)
        
        titleLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: contentView.rightAnchor,
                          paddingTop: 16,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0, height: 20)
        mainTextLabel.anchor(top: titleLabel.bottomAnchor,
                             left: contentView.leftAnchor,
                             bottom: contentView.bottomAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 10,
                             paddingLeft: 16,
                             paddingBottom: 30,
                             paddingRight: 16,
                             width: 0, height: 0)
        gradientView.anchor(top: nil,
                            left: contentView.leftAnchor,
                            bottom: contentView.bottomAnchor,
                            right: contentView.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 16,
                            paddingBottom: 30,
                            paddingRight: 16,
                            width: 0, height: 85)
        moreButtons.anchor(top: nil,
                           left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: nil,
                           paddingTop: 0,
                           paddingLeft: 16,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 0, height: 35)
    }
    
    @objc func moreButtonTapped() {
        delegate?.showMoreText()
    }
    
    func configureCell(titleName name: String, description: String) {
        titleLabel.text = name
        mainTextLabel.text = description
        let screenInsetsLeftRight: CGFloat = 32
        delegate?.heightCell(height: description.height(widthScreen: UIScreen.main.bounds.width - screenInsetsLeftRight,
                                                        font: UIFont(name: "GillSans-semibold", size: 16)!))
    }
}
