//
//  TeamDetailsPresenter.swift
//  SportsSpot
//
//  Created by Khokha on 28/04/2024.
//

import Foundation

class TeamDetailsPresenter{
    
    var VC: TeamDetailsProtocal?
    func featchLeague(sport:String , teamId:Int)
    {
        Network.shared.fetchTeam(sport: sport.lowercased(),teamID: teamId) { leagues in
            switch leagues {
            case .success(let done):
                self.VC?.featchTeamDetails(team: (done.result?[0])!)
            case .failure(let err):
                self.VC?.failure(msg: err.localizedDescription)
            }
        }
    }
}
