//
//  OrderItemModel.swift
//  SehatQTest
//
//  Created by reza pahlevi on 03/02/21.
//

import Foundation
import RealmSwift

class OrderItemModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var price: String = ""
}
