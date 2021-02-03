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
        if let dataHomeModel = RealmManager.shared.dataHomeModel?.first {
            let filtered = Array(dataHomeModel.productPromo.filter({$0.title.lowercased().contains(self.textSearch.lowercased())}))
            return filtered
        }
        return nil
    }
}
