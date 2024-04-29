//
//  Network.swift
//  SportsSpot
//
//  Created by Khokha on 22/04/2024.
//

import Foundation
import Alamofire

class Network  {
    static let shared : Network = Network()
    let apiKey = "6c1c88500e41b80918d93cf0cf1dfaa81b7cb613452241ab62f48a103781099e"
    private  init() {
        
    }
    
    
    func fetchLeagues(sport:String,completion: @escaping(Result<LeagueDto,Error>) -> Void) {
        
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(apiKey)")
        AF.request(url!).validate().response{
            respon in
            switch respon.result{
            case .success(let data):
                do{
                    let jsonData = try JSONDecoder().decode(LeagueDto.self, from: data!)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))

                }
            case .failure(let error):
                completion(.failure(error))

            }
            
        }
    }
    
    func fetchFixturesUpComingMatches(sport:String,leagueID:Int,completion: @escaping(Result<FixturesResult,Error>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=\(apiKey)&leagueId=\(leagueID)&from=\(formattedDate)&to=\(formattedDate)")
        //let url = URL(string: "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=6c1c88500e41b80918d93cf0cf1dfaa81b7cb613452241ab62f48a103781099e&leagueId=152&from=2024-04-28&to=2024-04-28")
        AF.request(url!).validate().response{
            respon in
            switch respon.result{
            case .success(let data):
                do{
                    let jsonData = try JSONDecoder().decode(FixturesResult.self, from: data!)
                    completion(.success(jsonData))
                    //print(jsonData.result)
                } catch {
                    completion(.failure(error))

                }
            case .failure(let error):
                completion(.failure(error))

            }
        }
    }
    func fetchFixturesLatestMatches(sport: String, leagueID: Int, completion: @escaping (Result<FixturesResult, Error>) -> Void) {
        let calendar = Calendar.current
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Get the previous day's date
        if let futureDate = calendar.date(byAdding: .day, value: -1, to: currentDate) {
            let futureDateFormatted = dateFormatter.string(from: futureDate)
            print(futureDateFormatted)
            
            // Get the date after 15 days
            if let previousDate = calendar.date(byAdding: .day, value: -15, to: currentDate) {
                let previousDateFormatted = dateFormatter.string(from: previousDate)
                print(previousDateFormatted)
                let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=\(apiKey)&leagueId=\(leagueID)&from=\(previousDateFormatted)&to=\(futureDateFormatted)"
                
                if let url = URL(string: urlString) {
                    AF.request(url).validate().response { response in
                        switch response.result {
                        case .success(let data):
                            do {
                                let jsonData = try JSONDecoder().decode(FixturesResult.self, from: data!)
                                completion(.success(jsonData))
                            } catch {
                                completion(.failure(error))
                            }
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
                    completion(.failure(error))
                }
            }
        }
    }
    func fetchLeaguesTeams(sport:String,leagueID:Int,completion:@escaping(Result<TeamResponse,Error>) -> Void){
        //https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=96&APIkey=6c1c88500e41b80918d93cf0cf1dfaa81b7cb613452241ab62f48a103781099e
        let urlString = "https://apiv2.allsportsapi.com/\(sport)/?&met=Teams&leagueId=\(leagueID)&APIkey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            AF.request(url).validate().response{response in
                switch response.result{
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(TeamResponse.self, from: data!)
                        print(jsonData.result?.count)
                        completion(.success(jsonData))
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                case .failure(let error ):
                    completion(.failure(error))
                }
                
            }
        }
    }
    
    //https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=96&APIkey=6c1c88500e41b80918d93cf0cf1dfaa81b7cb613452241ab62f48a103781099e
    func fetchTeam(sport:String,teamID:Int,completion:@escaping(Result<TeamResponse,Error>) -> Void){
        
        let urlString = "https://apiv2.allsportsapi.com/\(sport)/?&met=Teams&teamId=\(teamID)&APIkey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            AF.request(url).validate().response{response in
                switch response.result{
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(TeamResponse.self, from: data!)
                        completion(.success(jsonData))
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                case .failure(let error ):
                    completion(.failure(error))
                }
                
            }
        }
    }
    
}
