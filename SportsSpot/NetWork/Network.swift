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
                    print(jsonData.result?[0].country_name)
                    completion(.success(jsonData))
//                    print(jsonData.result)
                    
                  
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))

                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))

            }
            
        }
    }
    
    func fetchFixtures(sport:String,from dateFrom:Date?,completion: @escaping(Result<FixturesResult,Error>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        let fromDate = dateFormatter.string(from: dateFrom ?? currentDate)
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=\(apiKey)&from=\(fromDate)&to=\(formattedDate)")
        AF.request(url!).validate().response{
            respon in
            switch respon.result{
            case .success(let data):
                do{
                    let jsonData = try JSONDecoder().decode(FixturesResult.self, from: data!)
                    print(jsonData.result?[0].country_name)
                    completion(.success(jsonData))
                    
//                    print(jsonData.result)
                    
                  
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))

                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))

            }
            
        }
    }
}
