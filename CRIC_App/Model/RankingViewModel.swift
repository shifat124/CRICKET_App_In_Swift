// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let rankingModel = try? JSONDecoder().decode(RankingModel.self, from: jsonData)

import Foundation

// MARK: - RankingModel
struct RankingModel: Codable {
    let data: [RankingDatum]?
}

// MARK: - Datum
struct RankingDatum: Codable {
    let resource, type: String?
    let position, points, rating: JSONNull?
    let gender, updatedAt: String?
    let team: [RankingTeam]?

    enum CodingKeys: String, CodingKey {
        case resource, type, position, points, rating, gender
        case updatedAt = "updated_at"
        case team
    }
}

// MARK: - Team
struct RankingTeam: Codable {
    let resource: Resource?
    let id: Int?
    let name, code: String?
    let imagePath: String?
    let countryID: Int?
    let nationalTeam: Bool?
    let position: Int?
    let updatedAt: String?
    let ranking: Ranking?

    enum CodingKeys: String, CodingKey {
        case resource, id, name, code
        case imagePath = "image_path"
        case countryID = "country_id"
        case nationalTeam = "national_team"
        case position
        case updatedAt = "updated_at"
        case ranking
    }
}

// MARK: - Ranking
struct Ranking: Codable {
    let position, matches, points, rating: Int?
}

enum Resource: String, Codable {
    case teams = "teams"
}


