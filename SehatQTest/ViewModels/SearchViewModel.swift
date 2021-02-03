//
//  SearchViewModel.swift
//  SehatQTest
//
//  Created by reza pahlevi on 03/02/21.
//

import Foundation

class SearchViewModel: BaseViewModel {
    var textSearch = ""
    
    var productPromoList: [ProductPromo]? {
        if let category = RealmManager.shared.dataHomeModel?.first {
            
            let filtered = Array(category.productPromo.filter({$0.title.contains(self.textSearch)}))
            
            return filtered
        }
        return nil
    }
}
