//
//  DetailsProtocol.swift
//  SportsSpot
//
//  Created by AYA on 27/04/2024.
//

import Foundation

protocol DetailsProtocol{
    var sport:String? { get }
    var leagueInfo: MyLeagueDto? {get}
    
    func fetchUpCommingMatches(sports:[FixturesDto])
    func failure(msg:String)
    func fetchLatestMatches(sports:[FixturesDto])
    func fetchTeams(teams:[TeamDto])
}
