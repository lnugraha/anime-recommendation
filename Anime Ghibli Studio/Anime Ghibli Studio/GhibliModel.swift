//
//  GhibliModel.swift
//  Anime Ghibli Studio
//
//  Created by Leo Nugraha on 2022/6/10.
//

import Foundation
import SwiftUI

struct AnimeModel: Codable {

    var id: String
    var title: String

    var originalTitle: String
    var originalTitleRomanized: String
    var image: String?
    var movieBanner: String?
    var description: String

    var producer: String
    var director: String
    var releaseDate: Int
    var runningTime: Int
    var rtScore: Int

    var people: Array<CharacterModel>?
    var species: Array<SpeciesModel>?
    var locations: Array<LocationModel>?
    var vehicles: Array<VehicleModel>?
    var url: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case title

        case originalTitle = "original_title"
        case originalTitleRomanized = "original_title_romanised"
        case image
        case description
        case movieBanner = "movie_banner"
        
        case producer
        case director
        case releaseDate = "release_date"
        case runningTime = "running_time"
        case rtScore = "rt_score"

        case people
        case species
        case locations
        case vehicles
        case url
    }

    // static func == (lhs: AnimeModel, rhs: AnimeModel) -> Bool {
    //     return true
    // }

}

struct CharacterModel: Codable {

    var id: String
    var name: String
    var gender: String
    var age: Int
    var eyeColor: String
    var hairColor: String
    var films: Array<AnimeModel>?
    var species: SpeciesModel?
    var url: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case age
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
        case films
        case species
        case url
    }

    // static func == (lhs: CharacterModel, rhs: CharacterModel) -> Bool {
    //     return true
    // }

}

struct SpeciesModel: Codable {

    var id: String
    var name: String
    var classification: String
    var eyeColors: Array<String>?
    var hairColors: Array<String>?
    var people: Array<CharacterModel>?
    var films: Array<AnimeModel>?
    var url: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case classification
        case eyeColors = "eye_colors"
        case hairColors = "hair_colors"
        case people
        case films
        case url
    }

}

struct LocationModel: Codable {
    var id: String
    var terrain: String
    var name: String
    var climate: String
    var surfaceWater: String
    var resident: Array<CharacterModel>?
    var films: Array<AnimeModel>?
    var url: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case terrain
        case name
        case climate
        case surfaceWater = "surface_water"
        case resident
        case films
        case url
    }

}

struct VehicleModel: Codable {

    var id: String
    var name: String
    var vehicleClass: String
    var length: String
    var pilot: CharacterModel?
    var films: Array<AnimeModel>?
    var url: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case vehicleClass = "vehicle_class"
        case length
        case pilot
        case films
        case url
    }

}
