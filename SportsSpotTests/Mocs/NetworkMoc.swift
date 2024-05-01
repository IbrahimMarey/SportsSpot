//
//  NetworkMoc.swift
//  SportsSpotTests
//
//  Created by Khokha on 30/04/2024.
//

import Foundation
@testable import SportsSpot

class MockNetworkServices {
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    
    let leagueFakeJsonObj : [String:Any] = [
    
        "result":[
            ["league_key":4,
             "league_name":"UEFA Europa League",
             "country_key":1,
             "country_name":"eurocups",
             "league_logo":"logo",
             "country_logo":"logo"]
        ]
    ]
    
    let fixtureFakeJsonObj : [String:Any] = [
        "success": 1,
        "result": []
        
    ]
    
    let teamFakeJsonObj : [String:Any] = [
        "success": 1,
        "result": [
            "teamKey" : 96,
            "teamLogo" : "---"
        ]
    ]

    enum ResponseWithError : Error {
        case resposeError
    }
    
}


extension MockNetworkServices:NetworkProtocol {
    func fetchLeagues(sport: String, completion: @escaping (Result<SportsSpot.LeagueDto, Error>) -> Void) {
        var result : LeagueDto!
        do {
            let data = try JSONSerialization.data(withJSONObject: leagueFakeJsonObj)
            result = try JSONDecoder().decode(LeagueDto.self, from: data)
        }catch let error {
            print(error.localizedDescription)
        }
        if shouldReturnError{
            completion(.failure(ResponseWithError.resposeError))
        }else{
            completion(.success(result))
        }
    }
    
    func fetchFixturesUpComingMatches(sport: String, leagueID: Int, completion: @escaping (Result<SportsSpot.FixturesResult, Error>) -> Void) {
        var result : FixturesResult?
        do {
            var data = try JSONSerialization.data(withJSONObject: fixtureFakeJsonObj)
            result = try JSONDecoder().decode(FixturesResult.self, from: data)
            print("result \(result?.success)")
        }catch let error {
            print(error.localizedDescription)
        }
        if shouldReturnError{
            completion(.failure(ResponseWithError.resposeError))
        }else{
            completion(.success(result!))
        }
    }
    
    func fetchFixturesLatestMatches(sport: String, leagueID: Int, completion: @escaping (Result<SportsSpot.FixturesResult, Error>) -> Void) {
        var result : FixturesResult?
        do {
            var data = try JSONSerialization.data(withJSONObject: fixtureFakeJsonObj)
            result = try JSONDecoder().decode(FixturesResult.self, from: data)
            print("result \(result?.success)")
        }catch let error {
            print(error.localizedDescription)
        }
        if shouldReturnError{
            completion(.failure(ResponseWithError.resposeError))
        }else{
            completion(.success(result!))
        }
    }
    
    func fetchLeaguesTeams(sport: String, leagueID: Int, completion: @escaping (Result<SportsSpot.TeamResponse, Error>) -> Void) {
        var result : TeamResponse?
        do {
            var data = try JSONSerialization.data(withJSONObject: fixtureFakeJsonObj)
            result = try JSONDecoder().decode(TeamResponse.self, from: data)
            print("result \(result?.success)")
        }catch let error {
            print(error.localizedDescription)
        }
        if shouldReturnError{
            completion(.failure(ResponseWithError.resposeError))
        }else{
            completion(.success(result!))
        }
    }
    
    func fetchTeam(sport: String, teamID: Int, completion: @escaping (Result<SportsSpot.TeamResponse, Error>) -> Void) {
        var result : TeamResponse?
        do {
            var data = try JSONSerialization.data(withJSONObject: fixtureFakeJsonObj)
            result = try JSONDecoder().decode(TeamResponse.self, from: data)
            print("result \(result?.success)")
        }catch let error {
            print(error.localizedDescription)
        }
        if shouldReturnError{
            completion(.failure(ResponseWithError.resposeError))
        }else{
            completion(.success(result!))
        }
    }
    
}
