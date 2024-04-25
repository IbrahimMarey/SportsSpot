//
//  LeaguePresenter.swift
//  SportsSpot
//
//  Created by Khokha on 25/04/2024.
//

import Foundation

class LeaguePresenter{
    
    var VC: LeagueProtocal?
    func featchLeague(sport:String)
    {
        Network.shared.fetchLeagues(sport: sport.lowercased()) { leagues in
            switch leagues {
            case .success(let done):
                self.VC?.featchLeague(leagues: done.result!)
            case .failure(let err):
                self.VC?.failure(msg: err.localizedDescription)
            }
        }
    }
}
