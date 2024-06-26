//
//  DetailsPresenter.swift
//  SportsSpot
//
//  Created by AYA on 27/04/2024.
//

import Foundation

class DetailsPresenter{
    
    var detailsVC : DetailsProtocol?
    
    func attachView(v:DetailsProtocol){
        self.detailsVC = v
    }
    
    func fetchUpcomingMatches(sport:String,leagueId:Int){
        print("sport Presenter is \(sport)")
      
        Network.shared.fetchFixturesUpComingMatches(sport: sport, leagueID: leagueId){ resulte in
            switch resulte {
                case .success(let done):
                print(".success")
                self.detailsVC?.fetchUpCommingMatches(sports: done.result ?? [])
                    print("the result count \(done.result?.count)")
                case .failure(let err):
                self.detailsVC?.failure(msg: err.localizedDescription)
                    print("error \(err.localizedDescription)")
            }
            print("After presenter ")
        }
    }
    
    func fetchLatestMatches(sport:String,leagueId:Int){
        Network.shared.fetchFixturesLatestMatches(sport: sport, leagueID: leagueId){ resulte in
            switch resulte {
                case .success(let done):
                print(".success")
                self.detailsVC?.fetchLatestMatches(sports: done.result ?? [])
                print("the result count \(done.result?.count)")
                case .failure(let err):
                self.detailsVC?.failure(msg: err.localizedDescription)
                    print("error \(err.localizedDescription)")
            }
            print("After presenter ")
        }
    }
    func fetchLeagueTeams(sport:String, leagueId:Int){
        Network.shared.fetchLeaguesTeams(sport: sport, leagueID: leagueId) { resulte in
            switch resulte {
                case .success(let done):
                print(".success")
                self.detailsVC?.fetchTeams(teams: done.result ?? [])
                print("self.detailsVC?.fetchTeams the result count =============\(done.result?.count)")
                case .failure(let err):
                self.detailsVC?.failure(msg: err.localizedDescription)
                    print("error ======================= \(err.localizedDescription)")
            }
            print("After presenter ")
        }
    }
    
    func insertToCoreData(leagueInfo:MyLeagueDto){
        
        CoreDataImple.shared.insertLeague(League: leagueInfo)
    }
    func isLeagueFavourite(league:MyLeagueDto)->Bool{
        return CoreDataImple.shared.searchLeague(League: league)
    }
    func deleteFromFavourite(league:MyLeagueDto){
        CoreDataImple.shared.deleteLeague(League: league)
    }
}
