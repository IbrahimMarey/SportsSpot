//
//  TeamDetailsProtocal.swift
//  SportsSpot
//
//  Created by Khokha on 28/04/2024.
//

import Foundation

protocol TeamDetailsProtocal{
    var sport:String? { get }
    var teamId:Int? { get }
    func featchTeamDetails(team:TeamDto)
    func failure(msg:String)
}
