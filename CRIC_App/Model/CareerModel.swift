// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let careerDataModel = try? JSONDecoder().decode(CareerDataModel.self, from: jsonData)

import Foundation

// MARK: - CareerDataModel
struct CareerDataModel: Codable {
    let data: CareerDataClass?
}

// MARK: - DataClass
struct CareerDataClass: Codable {
    let resource: String?
    let id, country_id: Int?
    let firstname, lastname, fullname: String?
    let image_path: String?
    let dateofbirth, gender, battingstyle, bowlingstyle: String?
    let position: CareerPosition?
    let country: Country?
    let updated_at: String?
    let career: [Career]?
}

// MARK: - Career
struct Career: Codable {
    let resource, type: String?
    let season_id, player_id: Int?
    let batting: [String: Double]?
    let updated_at: String?
    let season: CareerSeason?
}

// MARK: - Season
struct CareerSeason: Codable {
    let resource: String?
    let id, league_id: Int?
    let name, code, updated_at: String?
}

// MARK: - Position
struct CareerPosition: Codable {
    let resource: String?
    let id: Int?
    let name: String?
}

// MARK: - Country
struct Country: Codable {
    let resource: String?
    let id, continent_id: Int?
    let name: String?
    let image_path: String?
    let updated_at: String?
}
