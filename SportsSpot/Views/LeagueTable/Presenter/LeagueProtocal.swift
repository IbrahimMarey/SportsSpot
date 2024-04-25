//
//  LeagueProtocal.swift
//  SportsSpot
//
//  Created by Khokha on 25/04/2024.
//

import Foundation

protocol LeagueProtocal{
    var sport:String? { get }
    func featchLeague(leagues:[MyLeagueDto])
    func failure(msg:String)
}
