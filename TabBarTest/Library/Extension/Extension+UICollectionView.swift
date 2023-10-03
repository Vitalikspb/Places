//
//  Extension+UICollectionView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2023.
//

import UIKit

protocol Reusable {
    static func reuseIdentifier() -> String
}

extension Reusable {
    static func reuseIdentifier() -> String {
        return String(describing: Self.self) // Identifier is equal to type name of class that adopts protocol
    }
}

extension UICollectionView {
    func register<CellType: UICollectionViewCell & Reusable>(_ cellClass: CellType.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier())
    }

    func registerReusableView<CellType: UICollectionReusableView & Reusable>(_ cellClass: CellType.Type, forSupplementaryViewOfKind kind: String) {
        register(cellClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: cellClass.reuseIdentifier())
    }

    func dequeueReusableCell<CellType: UICollectionViewCell & Reusable>(_ cellClass: CellType.Type, for indexPath: IndexPath) -> CellType {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CellType.reuseIdentifier(), for: indexPath) as? CellType else {
            fatalError("Unable to dequeue \(String(describing: cellClass)) with reuseId of \(cellClass.reuseIdentifier())")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<CellType: UICollectionReusableView & Reusable>(
        _ cellClass: CellType.Type,
        ofKind kind: String,
        for indexPath: IndexPath) -> CellType {

        guard let cell = dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: cellClass.reuseIdentifier(),
                for: indexPath) as? CellType
        else {
            fatalError("Unable to dequeue \(String(describing: cellClass)) with reuseId of \(cellClass.reuseIdentifier())")
        }

        return cell
    }
}
