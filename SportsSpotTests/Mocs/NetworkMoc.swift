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
    
        "result": [
            "sportName" : "football",
            "league_key" : 207
        ]
    ]
    
    let fixtureFakeJsonObj : [String:Any] = [
    
        "result": [
            "event_key" : 96,
            "league_key" : 207
        ]
    ]
    
    let teamFakeJsonObj : [String:Any] = [
    
        "result": [
            "teamKey" : 96,
            "teamLogo" : "---"
        ]
    ]

    
    
    
    enum ResponseWithError : Error {
        case resposeError
    }
    
    
    
}


extension MockNetworkServices {
    
    func fetchLeagueJson (complitionHandler : @escaping (LeagueDto?, Error?) -> Void) {
        
        var result : LeagueDto?
        
        do {
            var data = try JSONSerialization.data(withJSONObject: leagueFakeJsonObj)
            
            result = try JSONDecoder().decode(LeagueDto.self, from: data)
        }catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func fetchFixturesUpComingMatchesJson (complitionHandler : @escaping (FixturesResult?, Error?) -> Void) {
        
        var result : FixturesResult?
        
        do {
            var data = try JSONSerialization.data(withJSONObject: fixtureFakeJsonObj)
            
            result = try JSONDecoder().decode(FixturesResult.self, from: data)
        }catch let error {
            print(error.localizedDescription)
        }
        
    }
}
