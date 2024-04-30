//
//  SportsSpotTests.swift
//  SportsSpotTests
//
//  Created by Khokha on 30/04/2024.
//

import XCTest
@testable import SportsSpot

final class SportsSpotTests: XCTestCase {

    var network: NetworkProtocol!

        override func setUp() {
            super.setUp()
            network = Network.shared
        }

        override func tearDown() {
            network = nil
            super.tearDown()
        }

    //expection
    func testFetchLeagues() {

        let myExpectation = expectation(description: "Loading...")

        network.fetchLeagues(sport: "football") { leagues in
            switch leagues {
            case .success(let done):
                XCTAssertNotNil(done)
                myExpectation.fulfill()
            case .failure(_):
                XCTFail("error")
            }
        }

        waitForExpectations(timeout: 5)
     }

    func testFetchFixturesUpComingMatches() {
        let myExpectation = expectation(description: "Loading...")

        network.fetchFixturesUpComingMatches(sport: "football", leagueID: 207){ resulte in
            switch resulte {
                case .success(let done):
                    XCTAssertNotNil(done)
                myExpectation.fulfill()
                case .failure(let err):
                    XCTFail("error")
            }
        }
        waitForExpectations(timeout: 5)
     }


    //fetchFixturesLatestMatches
    func testFetchFixturesLatestMatches() {

        let myExpectation = expectation(description: "Loading...")

        network.fetchFixturesLatestMatches(sport: "football", leagueID: 207){ resulte in
            switch resulte {
                case .success(let done):
                    XCTAssertNotNil(done)
                myExpectation.fulfill()
                case .failure(let err):
                    XCTFail("error")
            }
        }
        waitForExpectations(timeout: 5)
     }
    
    //fetchLeaguesTeams
    func testFetchLeaguesTeams() {
        let myExpectation = expectation(description: "Loading...")
        network.fetchLeaguesTeams(sport: "football",leagueID: 207) { leagues in
            switch leagues {
            case .success(let done):
                XCTAssertNotNil(done)
                myExpectation.fulfill()
            case .failure(let err):
                print(err.localizedDescription)
                XCTFail("error")
                
            }
        }
        waitForExpectations(timeout: 5)
    }
        
    func testFetchTeam() {
        let myExpectation = expectation(description: "Loading...")
        network.fetchTeam(sport: "football",teamID: 96) { leagues in
            switch leagues {
            case .success(let done):
                XCTAssertNotNil(done)
                myExpectation.fulfill()
            case .failure(let err):
                print(err.localizedDescription)
                XCTFail("error")
            }
        }
        waitForExpectations(timeout: 5)
     }
    
    
    

   
    
    
}
