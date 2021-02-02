//
//  HomeModel.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import Foundation

// MARK: - HomeModel
struct HomeModel: Codable {
    let data: DataHomeModel?
}

// MARK: - DataHomeModel
struct DataHomeModel: Codable {
    let category: [Category]?
    let productPromo: [ProductPromo]?
}

// MARK: - Category
struct Category: Codable {
    let imageURL: String?
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case id, name
    }
}

// MARK: - ProductPromo
struct ProductPromo: Codable {
    let id: String?
    let imageURL: String?
    let title, productPromoDescription, price: String?
    let loved: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case title
        case productPromoDescription = "description"
        case price, loved
    }
}

typealias HerosModel = [HomeModel]
