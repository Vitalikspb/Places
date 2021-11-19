//
//  CountryDescriptionTableViewCell.swift
//  TabBarTest
//
//

import UIKit

class CountryDescriptionTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        label.text = "Описание города"
        return label
    }()
    private let mainTextLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black        
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = "lasdfalsdfh; asflsadh flasdflhdl hlshd flsdhf ls flsldf jlsfs a;lf sldf ls;dlfjh lsajfdlsdflj ljsdfl sdflkjs;d lj sld l;skadjh ljhl;sdjhflsa sdlakhjf l;jsdl jlsdj lfjsd;l ljs;f jl;saj ;lskjdf lsjad kj ksadl jl;sj ;sdj fjsdl;jsjdfjl;sa ;s;ldkfl ;js;fkjsa lasdfalsdfh; asflsadh flasdflhdl hlshd flsdhf ls flsldf jlsfs a;lf sldf ls;dlfjh lsajfdlsdflj ljsdfl sdflkjs;d lj sld l;skadjh ljhl;sdjhflsa sdlakhjf l;jsdl jlsdj lfjsd;l ljs;f jl;saj ;lskjdf lsjad kj ksadl jl;sj ;sdj fjsdl;jsjdfjl;sa ;s;ldkfl ;js;fkjsa lasdfalsdfh; asflsadh flasdflhdl hlshd flsdhf ls flsldf jlsfs a;lf sldf ls;dlfjh lsajfdlsdflj ljsdfl sdflkjs;d lj sld l;skadjh ljhl;sdjhflsa sdlakhjf l;jsdl jlsdj lfjsd;l ljs;f jl;saj ;lskjdf lsjad kj ksadl jl;sj ;sdj fjsdl;jsjdfjl;sa ;s;ldkfl ;js;fkjsa lasdfalsdfh; asflsadh flasdflhdl hlshd flsdhf ls flsldf jlsfs a;lf sldf ls;dlfjh lsajfdlsdflj ljsdfl sdflkjs;d lj sld l;skadjh ljhl;sdjhflsa sdlakhjf l;jsdl jlsdj lfjsd;l ljs;f jl;saj ;lskjdf lsjad kj ksadl jl;sj ;sdj fjsdl;jsjdfjl;sa ;s;ldkfl ;js;fkjsa lasdfalsdfh; asflsadh flasdflhdl hlshd flsdhf ls flsldf jlsfs a;lf sldf ls;dlfjh lsajfdlsdflj ljsdfl sdflkjs;d lj sld l;skadjh ljhl;sdjhflsa sdlakhjf l;jsdl jlsdj lfjsd;l ljs;f jl;saj ;lskjdf lsjad kj ksadl jl;sj ;sdj fjsdl;jsjdfjl;sa ;s;ldkfl ;js;fkjsa"
        return label
    }()
    private let gradientView = GradientView()
    private let moreButtons: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "GillSans-semibold", size: 16)
        button.setTitle("Читать дальше", for: .normal)
        return button
    }()
    // MARK: -  Public Properties
    
    static let identifier = "CountryDescriptionTableViewCell"
    
    
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
        self.backgroundColor = .white
        self.clipsToBounds = true
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 50),
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        gradientView.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0), UIColor.white]
        gradientView.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientView.layer.mask = maskLayer
        moreButtons.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(mainTextLabel)
        contentView.addSubview(gradientView)
        contentView.addSubview(moreButtons)
        
        titleLabel.anchor(top: contentView.topAnchor,
                            left: contentView.leftAnchor,
                            bottom: nil,
                            right: contentView.rightAnchor,
                            paddingTop: 10,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0, height: 20)
        mainTextLabel.anchor(top: titleLabel.bottomAnchor,
                             left: contentView.leftAnchor,
                             bottom: nil,
                             right: contentView.rightAnchor,
                             paddingTop: 10,
                             paddingLeft: 16,
                             paddingBottom: 0,
                             paddingRight: 16,
                             width: 0, height: 0)
        gradientView.anchor(top: nil,
                            left: contentView.leftAnchor,
                            bottom: contentView.bottomAnchor,
                            right: contentView.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0, height: 50)
        moreButtons.anchor(top: nil,
                           left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor,
                           paddingTop: 0,
                           paddingLeft: 0,
                           paddingBottom: 15,
                           paddingRight: 0,
                           width: 0, height: 30)
        
    }
    
    @objc func moreButtonTapped() {
        print("read more")
    }
}
