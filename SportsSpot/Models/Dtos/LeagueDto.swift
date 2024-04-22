//
//  LeagueDto.swift
//  SportsSpot
//
//  Created by Khokha on 22/04/2024.
//

import Foundation

struct MyLeagueDto: Codable {
    let league_key: Int?
    let league_name: String?
    let country_key: Int?
    let country_name: String?
    let league_logo: String?
    let country_logo: String?
}

struct LeagueDto :Codable {
    let success:Int?
    let result:[MyLeagueDto]?
}
