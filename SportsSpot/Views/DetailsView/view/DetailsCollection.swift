//
//  DetailsCollection.swift
//  SportsSpot
//
//  Created by AYA on 27/04/2024.
//

import Foundation
import UIKit
import Kingfisher
extension DetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
            case 0:
                return upComingMatches.count
            case 1:
                return latestMatches.count
            case 2:
                return teamsList.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        let matchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchesCell", for: indexPath) as! MatchesCollectionViewCell
        switch indexPath.section{
            case 0:
                let m = upComingMatches[indexPath.row]
                showMatchesResult(cell: matchCell, matchData: m)
                cell = matchCell
            case 1:
                let m = latestMatches[indexPath.row]
                showMatchesResult(cell: matchCell, matchData: m)
                cell = matchCell
            case 2:
                let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TeamCollectionViewCell
            teamCell.teamLabel.text = teamsList[indexPath.row].teamName
            KF.url(URL(string: teamsList[indexPath.row].teamLogo ?? ""))
                        .placeholder(UIImage(named: "playstore"))
                        .set(to: teamCell.teamImg)

            cell = teamCell
            
            default:
                break
        }
        return cell ?? UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func showMatchesResult(cell matchCell:MatchesCollectionViewCell,matchData m:FixturesDto){
        matchCell.homeTeamLabel.text = m.event_home_team
        matchCell.awayTeamLabel.text = m.event_away_team
        matchCell.dateLabel.text = m.event_date
        matchCell.timeLabel.text = m.event_time
        if let homeTeamLogo = m.home_team_logo{
            matchCell.homeTeamImg.sd_setImage(with: URL(string: homeTeamLogo),placeholderImage: UIImage(named: "images"))
        }
        if let awayTeamLogo = m.away_team_logo{
            matchCell.awayTeamImg.sd_setImage(with: URL(string: awayTeamLogo),placeholderImage: UIImage(named: "images"))
        }
        
        matchCell.scoreLabel.text = m.event_final_result
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section{
            case 2:
            let teamDetailsView = TeamDetailsView()
            teamDetailsView.sport = league?.sportName?.lowercased()
            teamDetailsView.teamId = teamsList[indexPath.row].teamKey
            
            self.navigationController?.pushViewController(teamDetailsView, animated: true)
            default:
                break
        }
    }
    
}

