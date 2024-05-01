//
//  NetworkProtocol.swift
//  SportsSpot
//
//  Created by AYA on 01/05/2024.
//

import Foundation

protocol NetworkProtocol{
    func fetchLeagues(sport:String,completion: @escaping(Result<LeagueDto,Error>) -> Void)
    func fetchFixturesUpComingMatches(sport:String,leagueID:Int,completion: @escaping(Result<FixturesResult,Error>) -> Void)
    func fetchFixturesLatestMatches(sport: String, leagueID: Int, completion: @escaping (Result<FixturesResult, Error>) -> Void)
    func fetchLeaguesTeams(sport:String,leagueID:Int,completion:@escaping(Result<TeamResponse,Error>) -> Void)
    func fetchTeam(sport:String,teamID:Int,completion:@escaping(Result<TeamResponse,Error>) -> Void)
}
