//
//  MainFloatingView.swift
//  TabBarTest
//
//

import UIKit

protocol MainFloatingViewDelegate: AnyObject {
    func makeCall()
    func openSite()
    func openVK()
    func openFaceBook()
    func openInstagram()
    func openYoutube()
}

class MainFloatingView: UIView {
    
    // MARK: - Public properties
    
    weak var delegate: MainFloatingViewDelegate?
    var stateFloatingFullView: Bool = false
    
    // MARK: - UI properties

    let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .setCustomColor(color: .separatorAppearanceView)
        view.layer.cornerRadius = 2
        return view
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "museumHermitage")
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.allowsSelection = false
        table.isUserInteractionEnabled = true
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private var smallView: Bool = true
    
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
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        tableView.isScrollEnabled = false
        stateFloatingFullView = false
        smallView = false
        reloadData()
    }
    
    func floatingPanelFullScreen() {
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = true
        stateFloatingFullView = true
        smallView = false
        reloadData()
    }
    
    func floatingPanelPatriallyScreen() {
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = false
        stateFloatingFullView = false
        smallView = true
        reloadData()
    }
    
    // MARK: - Helper functions
    
    private func configureUI() {
        self.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        addSubviews(imageView, indicatorView, tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FloatingViewFirstTableViewCell.self,
                           forCellReuseIdentifier: FloatingViewFirstTableViewCell.identifier)
        tableView.register(FloatingViewSecondTableViewCell.self,
                           forCellReuseIdentifier: FloatingViewSecondTableViewCell.identifier)
        tableView.register(FloatingViewThirdTableViewCell.self,
                           forCellReuseIdentifier: FloatingViewThirdTableViewCell.identifier)
        tableView.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        indicatorView.centerX(inView: self)
        indicatorView.anchor(top: topAnchor,
                             left: nil,
                             bottom: nil,
                             right: nil,
                             paddingTop: 8,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 72,
                             height: 4)
        imageView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: nil,
                         right: rightAnchor,
                         paddingTop: 21,
                         paddingLeft: 16,
                         paddingBottom: 0,
                         paddingRight: 16,
                         width: 0,
                         height: (UIScreen.main.bounds.height/4))
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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
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
                            showButtons: tableView.isScrollEnabled == true ? true : false,
                            smallView: smallView)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: FloatingViewSecondTableViewCell.identifier, for: indexPath) as! FloatingViewSecondTableViewCell
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: FloatingViewThirdTableViewCell.identifier, for: indexPath) as! FloatingViewThirdTableViewCell
            cell.delegate = self
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
        case 0: return stateFloatingFullView ? 88 : 200
            
        // ячейка с collectionView с картинками
        case 1: return 204
            
        // ячейка с контактами
        case 2: return 244
            
        default:
            return 200
        }
    }
}

extension MainFloatingView: FloatingViewThirdTableViewCellDelegate {
    func makeCall() {
        delegate?.makeCall()
    }
    
    func openSite() {
        delegate?.openSite()
    }
    
    func openVK() {
        delegate?.openVK()
    }
    
    func openFaceBook() {
        delegate?.openFaceBook()
    }
    
    func openInstagram() {
        delegate?.openInstagram()
    }
    
    func openYoutube() {
        delegate?.openYoutube()
    }
    
    
}
