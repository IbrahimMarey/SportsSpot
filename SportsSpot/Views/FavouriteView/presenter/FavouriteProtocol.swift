//
//  FavouriteProtocol.swift
//  SportsSpot
//
//  Created by AYA on 28/04/2024.
//

import Foundation

protocol FavouriteProtocol{
    
    var leaguesList: [MyLeagueDto]? {get set}
    func getDataFromCoreData()
    func deleteFromCoreData()
    
}
