//
//  TeamCollectionViewCell.swift
//  SportsSpot
//
//  Created by AYA on 27/04/2024.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBorder.layer.borderWidth = 1
        viewBorder.layer.borderColor = UIColor(red: 67/255, green: 74/255, blue: 249/255, alpha: 1.0).cgColor
        viewBorder.layer.cornerRadius = 10
    }

}
