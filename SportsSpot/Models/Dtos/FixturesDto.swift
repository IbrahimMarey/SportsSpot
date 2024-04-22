//
//  Fixtures.swift
//  SportsSpot
//
//  Created by Khokha on 22/04/2024.
//

import Foundation

struct FixturesResult :Codable {
    let success:Int?
    let result:[FixturesDto]?
}

struct FixturesDto: Codable {
    let event_key: Int?
    let event_date, event_time, event_home_team: String?
    let home_team_key: Int?
    let event_away_team: String?
    let away_team_key: Int?
    let event_halftime_result, event_final_result, event_ft_result, event_penalty_result: String?
    let event_status, country_name, league_name: String?
    let league_key: Int?
    let league_round, league_season, event_live, event_stadium: String?
    let event_referee: String?
    let home_team_logo, away_team_logo: String?
    let event_country_key: Int?
    let league_logo, country_logo: String?
    let event_home_formation, event_away_formation: String?
    let fk_stage_key: Int?
    let stage_name: String?
   // let league_group: JSONNull?
    let goalscorers: [Goalscorer]?
    let substitutes: [Substitute]?
    let cards: [Card]?
   // let vars: Vars
    let lineups: Lineups?
    let statistics: [Statistic]?
}

// MARK: - Card
struct Card: Codable {
    let time, home_fault, card, away_fault: String?
    let info, home_player_id, away_player_id, info_time: String?
}

// MARK: - Goalscorer
struct Goalscorer: Codable {
    let time, home_scorer, home_scorer_id, home_assist: String?
    let home_assist_id, score, away_scorer, away_scorer_id: String?
    let away_assist, away_assist_id, info, info_time: String?

    
}

// MARK: - Lineups
struct Lineups: Codable {
    let home_team, away_team: Team?
}

// MARK: - Team
struct Team: Codable {
    let starting_lineups, substitutes: [StartingLineup]?
    let coaches: [Coach]?
    //let missing_players: [JSONAny]

    
}

// MARK: - Coach
struct Coach: Codable {
    let coache: String?
//    let coache_country: JSONNull?

}

// MARK: - StartingLineup
struct StartingLineup: Codable {
    let player: String?
    let player_number, player_position: Int?
//    let player_country: JSONNull?
    let player_key: Int?
    let info_time: String?
}

// MARK: - Statistic
struct Statistic: Codable {
    let type, home, away: String?
}

// MARK: - Substitute
struct Substitute: Codable {
    let time: String?
   // let home_scorer: AwayScorerUnion
    //let home_assist: JSONNull?
    let score: String?
    //let away_scorer: AwayScorerUnion
    //let away_assist, info: JSONNull?
    let info_time: String?
}

//enum AwayScorerUnion: Codable {
//    case anythingArray([JSONAny])
//    case awayScorerClass(AwayScorerClass)
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let x = try? container.decode([JSONAny].self) {
//            self = .anythingArray(x)
//            return
//        }
//        if let x = try? container.decode(AwayScorerClass.self) {
//            self = .awayScorerClass(x)
//            return
//        }
//        throw DecodingError.typeMismatch(AwayScorerUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AwayScorerUnion"))
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        switch self {
//        case .anythingArray(let x):
//            try container.encode(x)
//        case .awayScorerClass(let x):
//            try container.encode(x)
//        }
//    }
//}

// MARK: - AwayScorerClass
//struct AwayScorerClass: Codable {
//    let in, out: String
//    let in_id, out_id: Int
//
//    enum CodingKeys: String, CodingKey {
//        case scorerIn = "in"
//        case out,in_id,out_id
//    }
//}

// MARK: - Vars
//struct Vars: Codable {
//    let home_team, away_team: [JSONAny]
//}

// MARK: - Encode/decode helpers

