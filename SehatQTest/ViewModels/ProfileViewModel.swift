//
//  ProfileViewModel.swift
//  SehatQTest
//
//  Created by reza pahlevi on 03/02/21.
//

import Foundation

class ProfileViewModel: BaseViewModel {
    
    var orderItemList: [OrderItemModel]? {
        if let orderItem = RealmManager.shared.orderItem {
            
            return Array(orderItem)
        }
        return nil
    }
    
    var productPromoList: [ProductPromo]? {
        if let category = RealmManager.shared.dataHomeModel?.first {
            
            return Array(category.productPromo)
        }
        return nil
    }
    
    func getProduct(_ productID: String) -> ProductPromo? {
        if let data = productPromoList?.filter({ $0.id == productID }) {
            return data.first
        }
        return nil
    }
}
