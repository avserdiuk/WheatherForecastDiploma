//
//  GeoDecoderManager.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 30.03.2023.
//

import Foundation

struct GeoDecoder: Codable {
    let response: Response
}

struct Response: Codable {
    let geoObjectCollection: GeoObjectCollection
    
    enum CodingKeys: String, CodingKey {
        case geoObjectCollection = "GeoObjectCollection"
    }
}

struct GeoObjectCollection: Codable {
    let featureMember: [FeatureMember]
}

struct FeatureMember: Codable {
    let geoObject: GeoObject
    
    enum CodingKeys: String, CodingKey {
        case geoObject = "GeoObject"
    }
}

struct GeoObject: Codable {
    let point: Point?
    let description : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case point = "Point"
        case description
        case name
    }
}

struct Point: Codable {
    let pos: String?
}

