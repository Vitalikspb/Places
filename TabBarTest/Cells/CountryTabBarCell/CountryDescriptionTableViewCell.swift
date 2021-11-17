//
//  CountryDescriptionTableViewCell.swift
//  TabBarTest
//
//

import UIKit

class CountryDescriptionTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    
    // MARK: -  Public Properties
    
    static let identifier = "CountryDescriptionTableViewCell"

    
    // MARK: - LifeCycle
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // MARK: - Helper functions
    
    private func setupUI() {
       
    }
}
