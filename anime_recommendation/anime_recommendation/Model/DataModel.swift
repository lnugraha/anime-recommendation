//
//  DataModel.swift
//  anime_recommendation
//
//  Created by Leo Nugraha on 2021/8/30.
//

import Foundation

struct GeneralEntry: Codable {
    var request_hash: String
    var request_cached: Bool
    var request_cache_expiry: Int
    var top: [AnimeProperties]
}

struct AnimeProperties: Codable {
    var mal_id: Int
    var rank: Int
    var title: String
    var url: String?
    var image_url: String?
    var type: String?
    var episodes: Int?
    var start_date: String?
    var end_date: String?
    var members: Int?
    var score: Double
}

final public class GlobalDataAccess {
    static let shared = GlobalDataAccess()
    var counter: Int = 1
}
