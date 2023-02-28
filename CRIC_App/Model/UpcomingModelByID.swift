//
//  UpcomingModelApi.swift
//  CRIC_App
//
//  Created by BJIT on 27/11/1401 AP.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let upcomingModelByID = try? JSONDecoder().decode(UpcomingModelByID.self, from: jsonData)

import Foundation

// MARK: - UpcomingModelByID
struct UpcomingModelByID: Codable {
    let data: DataClassByIdByid?
}

// MARK: - DataClassByIdByid
struct DataClassByIdByid: Codable {
    let resource: String?
       let id, leagueID, seasonID, stageID: Int?
       let round: String?
       let localteamID, visitorteamID: Int?
       let startingAt, type: String?
       let live: Bool?
       let status: String?
       let lastPeriod: JSONNull?
       let note: String?
       let venueID: Int?
       let tossWonTeamID, winnerTeamID, drawNoresult, firstUmpireID: JSONNull?
       let secondUmpireID, tvUmpireID, refereeID, manOfMatchID: JSONNull?
       let manOfSeriesID, totalOversPlayed, elected: JSONNull?
       let superOver, followOn: Bool?
       let localteamDLData, visitorteamDLData: UpcomeTeamDLDataById?
       let rpcOvers, rpcTarget: JSONNull?
       let weatherReport: [JSONAny]?
       let localteam, visitorteam: UpcomeTeamById?
       let runs: [JSONAny]?
       let venue: UpcomeVenueById?

       enum CodingKeys: String, CodingKey {
           case resource, id
           case leagueID = "league_id"
           case seasonID = "season_id"
           case stageID = "stage_id"
           case round
           case localteamID = "localteam_id"
           case visitorteamID = "visitorteam_id"
           case startingAt = "starting_at"
           case type, live, status
           case lastPeriod = "last_period"
           case note
           case venueID = "venue_id"
           case tossWonTeamID = "toss_won_team_id"
           case winnerTeamID = "winner_team_id"
           case drawNoresult = "draw_noresult"
           case firstUmpireID = "first_umpire_id"
           case secondUmpireID = "second_umpire_id"
           case tvUmpireID = "tv_umpire_id"
           case refereeID = "referee_id"
           case manOfMatchID = "man_of_match_id"
           case manOfSeriesID = "man_of_series_id"
           case totalOversPlayed = "total_overs_played"
           case elected
           case superOver = "super_over"
           case followOn = "follow_on"
           case localteamDLData = "localteam_dl_data"
           case visitorteamDLData = "visitorteam_dl_data"
           case rpcOvers = "rpc_overs"
           case rpcTarget = "rpc_target"
           case weatherReport = "weather_report"
           case localteam, visitorteam, runs, venue
       }
   }

    //MARK: - Team
   struct UpcomeTeamById: Codable {
       let resource: String?
       let id: Int?
       let name, code: String?
       let imagePath: String?
       let updatedAt: String?

       enum CodingKeys: String, CodingKey {
           case resource, id, name, code
           case imagePath = "image_path"
           case updatedAt = "updated_at"
       }
   }

    //MARK: - TeamDLData
   struct UpcomeTeamDLDataById: Codable {
       let score, overs, wicketsOut: JSONNull?

       enum CodingKeys: String, CodingKey {
           case score, overs
           case wicketsOut = "wickets_out"
       }
   }

    //MARK: - Venue
   struct UpcomeVenueById: Codable {
       let resource: String?
       let id, countryID: Int?
       let name, city: String?
       let imagePath: String?
       let capacity: Int?
       let floodlight: Bool?
       let updatedAt: String?

       enum CodingKeys: String, CodingKey {
           case resource, id
           case countryID = "country_id"
           case name, city
           case imagePath = "image_path"
           case capacity, floodlight
           case updatedAt = "updated_at"
       }
   }

