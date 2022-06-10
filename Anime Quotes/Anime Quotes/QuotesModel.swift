//
//  QuotesModel.swift
//  Anime Quotes
//
//  Created by Leo Nugraha on 2022/6/10.
//

import Foundation

struct QuotesModel: Codable {
    
    var anime: String
    var character: String
    var quote: String
    
}

let API_ENDPOINT_URL: String = "https://animechan.vercel.app/api/quotes"
