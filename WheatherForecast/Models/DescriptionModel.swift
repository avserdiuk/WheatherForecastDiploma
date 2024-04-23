////
////  DescriptionModel.swift
////  WheatherForecast
////
////  Created by Алексей Сердюк on 02.04.2023.
////
//
//import Foundation
//
//struct Description: Codable {
//    let response: Response
//}
//
//// MARK: - Response
//struct Response: Codable {
//    let geoObjectCollection: GeoObjectCollection
//
//    enum CodingKeys: String, CodingKey {
//        case geoObjectCollection = "GeoObjectCollection"
//    }
//}
//
//// MARK: - GeoObjectCollection
//struct GeoObjectCollection: Codable {
//    let metaDataProperty: GeoObjectCollectionMetaDataProperty
//    let featureMember: [FeatureMember]
//}
//
//// MARK: - FeatureMember
//struct FeatureMember: Codable {
//    let geoObject: GeoObject
//
//    enum CodingKeys: String, CodingKey {
//        case geoObject = "GeoObject"
//    }
//}
//
//// MARK: - GeoObject
//struct GeoObject: Codable {
//    let metaDataProperty: GeoObjectMetaDataProperty
//    let name: String
//    let description: String?
//    let boundedBy: BoundedBy
//    let point: Point
//
//    enum CodingKeys: String, CodingKey {
//        case metaDataProperty, name, description, boundedBy
//        case point = "Point"
//    }
//}
