//
//  TeamDto.swift
//  SportsSpot
//
//  Created by Khokha on 28/04/2024.
//

import Foundation

struct TeamResponse: Decodable {
    let success: Int
    let result: [TeamDto]?
}

// MARK: - Result
struct TeamDto : Decodable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let players: [Player]?
    let coaches: [CoachDto]?

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players, coaches
    }
}
