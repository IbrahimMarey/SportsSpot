//
//  LeaguesTableViewCell.swift
//  SportsSpot
//
//  Created by AYA on 24/04/2024.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var leageuImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leageuImage.layer.cornerRadius = leageuImage.frame.width / 2
        leageuImage.clipsToBounds = true
        viewBorder.layer.borderWidth = 1
        viewBorder.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        viewBorder.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    override func layoutSubviews() {
//        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//        viewBorder.layer.borderWidth = 1
//        viewBorder.layer.borderColor = UIColor(red: 67/255, green: 74/255, blue: 249/255, alpha: 1.0).cgColor
//        viewBorder.layer.cornerRadius = 10
//
//    }
    
}
