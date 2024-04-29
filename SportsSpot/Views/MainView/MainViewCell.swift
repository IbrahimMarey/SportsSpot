//
//  MainViewCell.swift
//  SportsSpot
//
//  Created by Khokha on 23/04/2024.
//

import UIKit

class MainViewCell: UICollectionViewCell {

    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCell.layer.cornerRadius = 25

        viewBorder.layer.borderWidth = 2
        viewBorder.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        viewBorder.layer.cornerRadius = 15
    }
    
    

}
