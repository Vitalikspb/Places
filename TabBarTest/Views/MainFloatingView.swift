//
//  MainFloatingView.swift
//  TabBarTest
//
//

import UIKit

protocol MainFloatingViewDelegate: AnyObject {
    func closeFloatingView()
}

class MainFloatingView: UIView {
    
    // MARK: - Public properties
    
    weak var delegate: MainFloatingViewDelegate?
    var stateFloatingFullView: Bool = false
    
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
        button.setImage(UIImage(named: "close"), for: .normal)
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
        table.allowsSelection = false
        table.isUserInteractionEnabled = true
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
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
        stateFloatingFullView = false
        reloadData()
    }
    
    func floatingPanelFullScreen() {
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = true
        UIView.animate(withDuration: 0.52) {
            self.closeButton.alpha = 1
        }
        stateFloatingFullView = true
        reloadData()
    }
    
    func floatingPanelPatriallyScreen() {
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = false
        UIView.animate(withDuration: 0.4) {
            self.closeButton.alpha = 0
        }
        stateFloatingFullView = false
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
        tableView.register(FloatingViewSecondTableViewCell.self,
                           forCellReuseIdentifier: FloatingViewSecondTableViewCell.identifier)
        tableView.register(FloatingViewThirdTableViewCell.self,
                           forCellReuseIdentifier: FloatingViewThirdTableViewCell.identifier)
        
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
                           paddingBottom: 0,
                           paddingRight: 10,
                           width: 30,
                           height: 30)
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

// MARK: - UIScrollViewDelegate

extension MainFloatingView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        if scrollView == self.tableView {
            if yOffset <= 0 {
                self.tableView.isScrollEnabled = false
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainFloatingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: FloatingViewFirstTableViewCell.identifier, for: indexPath) as! FloatingViewFirstTableViewCell
            cell.configCell(title: "Самый лучший музей",
                            type: "Музей",
                            showButtons: tableView.isScrollEnabled == true ? true : false)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: FloatingViewSecondTableViewCell.identifier, for: indexPath) as! FloatingViewSecondTableViewCell
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: FloatingViewThirdTableViewCell.identifier, for: indexPath) as! FloatingViewThirdTableViewCell
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        // первая ячейка
        case 0: return stateFloatingFullView ? 135 : 200
            
        // ячейка с collectionView с картинками
        // размер ячеек - картинок равен 180х140
        case 1: return 200
        // ячейка с контактами
            
        case 2: return 310
            
        default:
            return 200
        }
    }
}
