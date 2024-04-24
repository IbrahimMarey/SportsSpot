//
//  CoreDataProtocol.swift
//  SportsSpot
//
//  Created by AYA on 24/04/2024.
//

import Foundation

protocol CoreDataProtocol{
    func fetchingData() -> [MyLeagueDto]
    func insertLeague(League l:MyLeagueDto) -> Void
    func deleteLeague(League l:MyLeagueDto) -> Void
}
