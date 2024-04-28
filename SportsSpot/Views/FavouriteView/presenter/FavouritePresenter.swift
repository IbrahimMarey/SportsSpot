//
//  FavouritePresenter.swift
//  SportsSpot
//
//  Created by AYA on 28/04/2024.
//

import Foundation

class FavouritePresenter{
    var vc:FavouriteProtocol?
    
    func attachView(vc:FavouriteProtocol){
        self.vc = vc
    }
    func getDataFromCoreData(){
        vc?.leaguesList = CoreDataImple.shared.fetchingData()
        print("\(vc?.leaguesList?.count)")
        vc?.getDataFromCoreData()
    }
    func deleteFromCoreData(league l:MyLeagueDto){
        CoreDataImple.shared.deleteLeague(League: l)
        vc?.deleteFromCoreData()
    }
    
}
