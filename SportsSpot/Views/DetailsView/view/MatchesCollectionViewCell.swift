//
//  MatchesCollectionViewCell.swift
//  SportsSpot
//
//  Created by AYA on 27/04/2024.
//

import UIKit

class MatchesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewBorder: UIView!
    
    @IBOutlet weak var awayTeamImg: UIImageView!

    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var homeTeamImg: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
            awayTeamImg.layer.cornerRadius = awayTeamImg.frame.width / 2
            awayTeamImg.clipsToBounds = true
        
        homeTeamImg.layer.cornerRadius = homeTeamImg.frame.width / 2
        homeTeamImg.clipsToBounds = true
        viewBorder.layer.borderWidth = 1
        viewBorder.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        viewBorder.layer.cornerRadius = 10
    }

}
