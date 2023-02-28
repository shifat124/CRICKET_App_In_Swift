//
//  SearchPlayerModel.swift
//  CRIC_App
//
//  Created by BJIT on 05/12/1401 AP.
//


import Foundation

// MARK: - SearchPlayer
struct SearchPlayer: Codable {
    let data: [DatumSearchPlayer]?
}

// MARK: - Datum
struct DatumSearchPlayer: Codable {
    let id: Int?
    let fullname: String?
    let image_path: String?
    let updatedAt: String?
}

