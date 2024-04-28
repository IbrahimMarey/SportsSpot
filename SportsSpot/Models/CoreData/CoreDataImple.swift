//
//  CoreDataImple.swift
//  SportsSpot
//
//  Created by AYA on 24/04/2024.
//

import Foundation
import UIKit
import CoreData

private let entityName = "Leagues"
enum LeagueKeys: String {
    case leagueKey = "league_key"
    case leagueName = "league_name"
    case countryKey = "country_key"
    case leagueLogo = "league_logo"
    case countryLogo = "country_logo"
    case countryName = "country_name"
    case sportName = "sport_name"
}

class CoreDataImple: CoreDataProtocol {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context:NSManagedObjectContext
    
    static let shared:CoreDataImple = CoreDataImple();
    private init() {
        context = appDelegate.persistentContainer.viewContext
    }
    
    func fetchingData() -> [MyLeagueDto] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        var leaguesList = [MyLeagueDto]()
        do{
            let leagues = try context.fetch(fetchRequest)
            for l in leagues{
                var lLogo :String!
                if let lKey = l.value(forKey: LeagueKeys.leagueKey.rawValue) as? Int,
                   let lName = l.value(forKey: LeagueKeys.leagueName.rawValue) as? String,
                   let lSport = l.value(forKey: LeagueKeys.sportName.rawValue) as? String
                   {
                    if let leagueLogo = l.value(forKey: LeagueKeys.leagueLogo.rawValue) as? String {
                        lLogo = leagueLogo
                    }else{
                        lLogo = ""
                    }
                    let league = MyLeagueDto(league_key: lKey, league_name: lName, country_key: nil, country_name: nil, league_logo: lLogo, country_logo: nil,sportName: lSport)
                    leaguesList.append(league)
                }else{
                    print("The League key \(l.value(forKey: LeagueKeys.leagueKey.rawValue))\n LName \(l.value(forKey: LeagueKeys.leagueName.rawValue)) \n L Logo \(l.value(forKey: LeagueKeys.leagueLogo.rawValue)) \n \(l.value(forKey: LeagueKeys.sportName.rawValue))   is nil core date.\n")
                    
                }
            }
            print("leaguesList count is \(leaguesList.count)")
            return leaguesList
        }catch {
            print("Error fetching leagues: \(error)")
            return [] 
        }
    }
    
    func insertLeague(League l: MyLeagueDto) {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
                print("Failed to retrieve entity description")
                return
            }
        let league = NSManagedObject(entity: entity, insertInto: context)
        league.setValue(l.league_key, forKey: LeagueKeys.leagueKey.rawValue)
        league.setValue(l.league_name, forKey: LeagueKeys.leagueName.rawValue)
        league.setValue(l.league_logo, forKey: LeagueKeys.leagueLogo.rawValue)
        league.setValue(l.sportName, forKey: LeagueKeys.sportName.rawValue)
        
        do{
            try context.save()
          print("Added successfully")
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func deleteLeague(League l: MyLeagueDto) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        print("LEaguf key in delete core Data \(l.league_key)")
        fetchRequest.predicate = NSPredicate(format: "league_key == %d", l.league_key!)
        do {
            let leagues = try context.fetch(fetchRequest)
            if let leagueToDelete = leagues.first {
                context.delete(leagueToDelete)
                try context.save()
            } else {
                print("League not found in Core Data")
            }
        } catch {
            print("Error deleting league: \(error)")
        }
    }
    
    func searchLeague(League l: MyLeagueDto) -> Bool {
        let allLeague = self.fetchingData()
       return allLeague.contains { le in
           return le.league_key == l.league_key
        }
    }
    
}
