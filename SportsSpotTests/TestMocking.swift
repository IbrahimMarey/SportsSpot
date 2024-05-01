//
//  TestMocking.swift
//  SportsSpotTests
//
//  Created by AYA on 01/05/2024.
//

import XCTest
@testable import SportsSpot

final class TestMocking: XCTestCase {
    var mockObj : NetworkProtocol!

    override func setUpWithError() throws {
        mockObj = MockNetworkServices(shouldReturnError: false)

    }

    override func tearDownWithError() throws {
        mockObj = nil
    }

    func testFetchLeagueFromMockingJson() {
        mockObj.fetchLeagues(sport: "football", completion: { result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let err):
                XCTFail()
            }
        })
    }
    
    func testFetchFixturesUpComingMatchesJsonFromMockingJson() {
        mockObj.fetchFixturesUpComingMatches(sport: "football", leagueID: 270, completion: { result in
            switch result{
            case .success(let data):
                //XCTAssertNotNil(data)
                XCTAssertEqual(data.success, 1)
            case .failure(let err):
                XCTFail()
            }
        })
    }
    func testFetchFixturesLatestMatchesJsonFromMockingJson() {
        mockObj.fetchFixturesLatestMatches(sport: "football", leagueID: 270, completion: { result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let err):
                XCTFail()
            }
        })
    }
    
    func testFetchLeaguesTeams(){
        mockObj.fetchLeaguesTeams(sport: "football", leagueID: 270, completion: { result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let err):
                XCTFail()
            }
        })
    }

    func testFetchTeams(){
        mockObj.fetchTeam(sport: "football", teamID: 2, completion: { result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let err):
                XCTFail()
            }
        })
    }
}
