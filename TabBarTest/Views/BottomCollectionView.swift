//
//  BottomCollectionView.swift
//  TabBarTest
//
//

import UIKit

protocol BottomCollectionViewDelegate: AnyObject {
    func showSight(nameSight: String)
}

class BottomCollectionView: UIView {
    
    struct BottomCollectionViewModel {
        var type: String
        var image: String
        var nameOfSight: String
        var typeSight: TypeSight
    }
    
    // MARK: - Public properties
    
    weak var delegate: BottomCollectionViewDelegate?
    var stateFloatingFullView: Bool = false
    var dataModel = [BottomCollectionViewModel]()
    
    
    // MARK: - UI properties

    let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper functions
    
    func setupModel(model: [Sight]) {
        model.forEach {
            let tempModel = BottomCollectionViewModel(type: $0.type.rawValue,
                                                      image: $0.big_image,
                                                      nameOfSight: $0.name,
                                                      typeSight: $0.type)
            dataModel.append(tempModel)
        }
    }
    
    private func configureUI() {
        self.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.register(BottomCollectionViewCollectionViewCell.self,
                                forCellWithReuseIdentifier: BottomCollectionViewCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.setCollectionViewLayout(layout, animated: true)

        self.addSubview(collectionView)
        collectionView.addConstraintsToFillView(view: self)
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension BottomCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomCollectionViewCollectionViewCell.identifier, for: indexPath) as? BottomCollectionViewCollectionViewCell else { return UICollectionViewCell() }
        let data = dataModel[indexPath.row]
        cell.conigureCell(type: data.type,
                          name: data.nameOfSight,
                          image: UIImage(named: data.image) ?? UIImage(),
                          typeSight: data.typeSight)
        cell.delegate = self
        return cell
    }
    
    // Размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-120, height: 88)
    }
    
    // Отступы от краев экрана на крайних ячейках
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    // Расстояние между ячейками - белый отступ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

// MARK: - BottomCollectionViewCollectionViewCellDelegate

extension BottomCollectionView: BottomCollectionViewCollectionViewCellDelegate {
    
    func tapSight(name: String) {
        delegate?.showSight(nameSight: name)
    }

}
