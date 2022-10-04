//
//  JSONModel.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 03.10.2022.
//

import Foundation

struct JSONSerializationModel {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

struct JSONDecodingModel: Codable {
    let name: String
    let rotation_period: Int
    let orbital_period: Int
    let diameter: Int
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: Bool
    let population:  Int
    let residents: [String]
    let films: [String]
    let created: Date
    let edited: Date//"2014-12-20T20:58:18.411000Z",
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name,
             rotation_period,
             orbital_period,
             diameter,
             climate,
             gravity,
             terrain,
             surface_water,
             population,
             residents,
             films,
             created,
             edited,
             url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let utcISODateFormatter = ISO8601DateFormatter()

        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.rotation_period = Int(try container.decodeIfPresent(String.self, forKey: .rotation_period) ?? "0") ?? 0
        self.orbital_period = Int(try container.decodeIfPresent(String.self, forKey: .orbital_period) ?? "0") ?? 0
        self.diameter = Int(try container.decodeIfPresent(String.self, forKey: .diameter) ?? "0") ?? 0
        self.climate = try container.decodeIfPresent(String.self, forKey: .climate) ?? ""
        self.gravity = try container.decodeIfPresent(String.self, forKey: .gravity) ?? ""
        self.terrain = try container.decodeIfPresent(String.self, forKey: .terrain) ?? ""
        self.surface_water = Bool(try container.decodeIfPresent(String.self, forKey: .surface_water) ?? "") ?? false
        self.population = Int(try container.decodeIfPresent(String.self, forKey: .population) ?? "0") ?? 0
        self.residents = try container.decodeIfPresent([String].self, forKey: .residents) ?? []
        self.films = try container.decodeIfPresent([String].self, forKey: .films) ?? []
        self.created = utcISODateFormatter.date(from: try container.decodeIfPresent(String.self, forKey: .created) ?? "") ?? Date()
        self.edited = utcISODateFormatter.date(from: try container.decodeIfPresent(String.self, forKey: .edited) ?? "") ?? Date()
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
}
