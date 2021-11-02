//
//  MainFloatingView.swift
//  TabBarTest
//
//  Created by ViceCode on 18.10.2021.
//

import UIKit

protocol MainFloatingViewDelegate: AnyObject {
    func closeFloatingView()
}

class MainFloatingView: UIView {
    
    // MARK: - Public properties
    
    weak var delegate: MainFloatingViewDelegate?
    var stateFloatingView: Bool = false
    
    // MARK: - UI properties
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        view.alpha = 0.8
        return view
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "new-york")
        return imageView
    }()
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        button.imageView?.tintColor = .lightGray
        button.backgroundColor = .clear
        button.alpha = 0
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(closeFloatingView), for: .touchUpInside)
        return button
    }()
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.allowsSelection = false
        table.isUserInteractionEnabled = true
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    // cell 1
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let typeLocationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    let imagesScrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    let locationImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    
    // cell 2
    //        let titleNameLabel
    //        let addressTopLabel
    //        let typeLabel
    //        let openLabel
    //        let whenClosedToday
    let cellImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    let cellTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    //for cell with work time
    let cellArrowImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    private var shapeLayer: CALayer?
    //    cell 1
    //    let titleNameLabel
    //    let addressTopLabel
    //    let typeLabel
    //    let openLabel
    //    let whenClosedToday
    
    //    let actionButtonsScrollView
    //    let favouriteButton
    //    let routeButton
    //    let cellButton
    //    let shareButton
    //    let siteButton
    
    //    cell 2
    //    let additionalImagesScrollView
    
    //    cell 3
    //    let addressTitleLabel
    //    let addressLabel
    
    //    cell 4
    //    let contactTitlelabel
    //    let phoneLabel
    //    let siteLabel
    
    //    cell 5
    //    let scheduleTitleLabel
    //    let scheduleLabel
    //    let scheduleButton
    //    let scheduleView
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Static function
    
    func floatingPanelIsHidden() {
        tableView.isUserInteractionEnabled = false
        tableView.isScrollEnabled = false
        UIView.animate(withDuration: 0.4) {
            self.closeButton.alpha = 0
        }
        reloadData()
    }
    
    func floatingPanelFullScreen() {
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = true
        UIView.animate(withDuration: 0.52) {
            self.closeButton.alpha = 1
        }
        reloadData()
    }
    
    func floatingPanelPatriallyScreen() {
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = false
        UIView.animate(withDuration: 0.4) {
            self.closeButton.alpha = 0
        }
        reloadData()
    }
    
    // MARK: - Helper functions
    
    private func configureUI() {
        self.backgroundColor = .white
        addSubview(imageView)
        addSubview(indicatorView)
        addSubview(tableView)
        addSubview(closeButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FloatingViewFirstTableViewCell.self,
                           forCellReuseIdentifier: FloatingViewFirstTableViewCell.identifier)
        imageView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: nil,
                         right: rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0,
                         height: (UIScreen.main.bounds.height/4))
        indicatorView.centerX(inView: self)
        indicatorView.anchor(top: imageView.bottomAnchor,
                             left: nil,
                             bottom: nil,
                             right: nil,
                             paddingTop: 8,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 80,
                             height: 6)
        closeButton.anchor(top: imageView.bottomAnchor,
                           left: nil,
                           bottom: nil,
                           right: rightAnchor,
                           paddingTop: 10,
                           paddingLeft: 0,
                           paddingBottom: 10,
                           paddingRight: 0,
                           width: 35,
                           height: 35)
        tableView.anchor(top: imageView.bottomAnchor,
                           left: leftAnchor,
                           bottom: bottomAnchor,
                           right: rightAnchor,
                           paddingTop: 15,
                           paddingLeft: 0,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 0,
                           height: 0)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Selectors
    
    @objc private func closeFloatingView() {
        delegate?.closeFloatingView()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainFloatingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
         let cell = tableView.dequeueReusableCell(withIdentifier: FloatingViewFirstTableViewCell.identifier, for: indexPath) as! FloatingViewFirstTableViewCell
            cell.configCell(title: "Самый лучший музей",
                            type: "Музей",
                            showButtons: tableView.isScrollEnabled == true ? true : false)
        return cell
        } else {
        return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200 
    }
}
