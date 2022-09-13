//
//  WeebsModel.swift
//  weebs_swiftui
//
//  Created by Leo Nugraha on 2022/9/13.
//

import Foundation

struct GeneralEntry: Codable {
    var requestHash: String
    var requestCached: Bool
    var requestCacheExpiry: Int
    var top: [AnimeProperties]
    
    private enum CodingKeys: String, CodingKey {
        case requestHash = "request_hash"
        case requestCached = "request_cached"
        case requestCacheExpiry = "request_cache_expiry"
        case top
    }

}

struct AnimeProperties: Codable {
    var malId: Int
    var rank: Int
    var title: String
    
    var url: String?
    var imageUrl: String?
    var type: String?
    
    var episodes: Int?
    var startDate: String?
    var endDate: String?
    
    var members: Int?
    var score: Double
    
    private enum CodingKeys: String, CodingKey {
        case malId      = "mal_id"
        case rank       = "rank"
        case title      = "title"
        
        case url        = "url"
        case imageUrl   = "image_url"
        case type       = "type"
        
        case episodes   = "episodes"
        case startDate  = "start_date"
        case endDate    = "end_date"
        
        case members    = "members"
        case score      = "score"
    }
    
}
