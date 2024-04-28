//
//  TeamDetailsView.swift
//  SportsSpot
//
//  Created by Khokha on 28/04/2024.
//

import UIKit

class TeamDetailsView: UIViewController, TeamDetailsProtocal {
    var sport: String?
    
    var teamId: Int?
    
    func featchTeamDetails(team: TeamDto) {
        print(team.teamName!)
        print(team.teamKey!)
        print(team.teamLogo!)
    }
    
    func failure(msg: String) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = TeamDetailsPresenter()
        presenter.VC = self
        presenter.featchLeague(sport: sport!, teamId: teamId!)

    }

    
}
