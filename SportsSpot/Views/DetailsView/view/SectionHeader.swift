//
//  SectionHeader.swift
//  SportsSpot
//
//  Created by Khokha on 29/04/2024.
//

import Foundation
import UIKit

class SectionHeaderView: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        // Customize label properties here
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Add and customize subviews (e.g., titleLabel) here
        
        // Example: Adding titleLabel as a subview
        addSubview(titleLabel)
        
        // Example: Setting up constraints for titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            // Add more constraints as needed
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
