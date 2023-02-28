
import Foundation



struct UpcomingMatch: Codable{
    let data: [UpcomingMatchData]?
}
struct UpcomingMatchData: Codable{
    let resources: UpcomingResources?
    let id, leagueID, seasonID, stageID: Int?
    let round: String?
    let localteamID, visitorteamID: Int?
    let starting_at: String?
    let type: TypeEnums?
    let status: Status1?
    let note: String?
    let venueID: Int?
    let venue: Venues?
    let league, localteam, visitorteam: Leagues?
    
    enum CodingKeys1: String, CodingKey {
            case resources, id
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
            case league, localteam, visitorteam, runs, manofmatch, venue
        }
    
}
enum UpcomingResources: String, Codable {
    case fixtures = "fixtures"
}
enum TypeEnums: String, Codable {
    case odi = "ODI"
    case t20 = "T20"
    case t20I = "T20I"
}
enum Status1: String, Codable {
    case finished = "NS"
}
struct Leagues: Codable {
    let resource: LeagueResources?
    let id: Int?
    let name, code, updatedAt: String?
    let imagePath: String?

    enum CodingKeys: String, CodingKey {
        case resource, id, name, code
        case updatedAt = "updated_at"
        case imagePath = "image_path"
    }
}
enum LeagueResources: String, Codable {
    case leagues = "leagues"
    case teams = "teams"
}
struct Venues: Codable {
    let resource: VenueResources?
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

enum VenueResources: String, Codable {
    case venues = "venues"
}
