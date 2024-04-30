//
//  SportsSpotTests.swift
//  SportsSpotTests
//
//  Created by Khokha on 30/04/2024.
//

import XCTest
@testable import SportsSpot

final class SportsSpotTests: XCTestCase {

    var network: Network!
    var mockObj : MockNetworkServices!

        override func setUp() {
            super.setUp()
            network = Network.shared
            mockObj = MockNetworkServices(shouldReturnError: false)
        }

        override func tearDown() {
            network = nil
            super.tearDown()
        }

    func testExample() throws {

    }

    func testPerformanceExample() throws {
        measure {
        }
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

    
    ///
    /// MOC
    ///
    ///
    ///

    func testFetchLeagueFromMockingJson() {

        mockObj.fetchLeagueJson {
            result, error in
            if let error = error {
                XCTFail()
            }else{
                XCTAssertNotNil(result)
            }
        }
    }
    
    func testFetchFixturesUpComingMatchesJsonFromMockingJson() {

        mockObj.fetchFixturesUpComingMatchesJson{
            result, error in
            if let error = error {
                XCTFail()
            }else{
                XCTAssertNotNil(result)
            }
        }
    }

   
    
    
}
