//
//  HomeModel.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import Foundation
import RealmSwift

typealias HomesModel = [HomeModel]

// MARK: - HomeModel
struct HomeModel: Codable {
    let data: DataHomeModel?
}

// MARK: - DataHomeModel
@objcMembers class DataHomeModel: Object, Codable {
    var category = List<CategoryHome>()
    var productPromo = List<ProductPromo>()
    
    enum CodingKeys: String, CodingKey {
        case category
        case productPromo
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let listCategory = try container.decode([CategoryHome].self, forKey: .category)
        category.append(objectsIn: listCategory)
        
        let listProductPromo = try container.decode([ProductPromo].self, forKey: .productPromo)
        productPromo.append(objectsIn: listProductPromo)
        
        
        super.init()
    }
    
    required init()
    {
        super.init()
    }
}

// MARK: - Category
@objcMembers class CategoryHome: Object, Codable {
    @objc dynamic var imageURL: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case id, name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        name = try container.decode(String.self, forKey: .name)
        super.init()
    }
    
    required init()
    {
        super.init()
    }
}

// MARK: - ProductPromo
@objcMembers class ProductPromo: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var productPromoDescription: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var loved: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case title
        case productPromoDescription = "description"
        case price, loved
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        productPromoDescription = try container.decode(String.self, forKey: .productPromoDescription)
        price = try container.decode(String.self, forKey: .price)
        loved = try container.decode(Int.self, forKey: .loved)
        super.init()
    }
    
    required init()
    {
        super.init()
    }
}


