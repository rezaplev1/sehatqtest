//
//  HomeViewModel.swift
//  SehatQTest
//
//  Created by reza pahlevi on 03/02/21.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func success()
    func failedReq(message: String)
    
}

class HomeViewModel: BaseViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    var categoryHomeList: [CategoryHome]? {
        if let category = RealmManager.shared.dataHomeModel?.first {
            
            return Array(category.category)
        }
        return nil
    }
    
    var productPromoList: [ProductPromo]? {
        if let category = RealmManager.shared.dataHomeModel?.first {
            
            return Array(category.productPromo)
        }
        return nil
    }
    
    func getHome(){
        api.getRequest(ServiceConfig.getHome)
    }
    
    override init() {
        super.init()
    }
    
    override func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do {
            switch interFace.serviceConfig {
            case .getHome:
                let response = try JSONDecoder().decode(HomesModel.self, from: data)                
                
                if let data = response.first?.data {
                    RealmManager.shared.deleteAllDataForObject(DataHomeModel.self)
                    RealmManager.shared.add(data)
                }
                
                delegate?.success()
            default:
                break
            }
        }  catch _ {
            delegate?.failedReq(message: "Error mapping data")
        }
    }
    
    override func failed(interFace: CoreApi, result: AnyObject) {
        if let response = result as? String {
            delegate?.failedReq(message: response)
        }else{
            delegate?.failedReq(message: "something went wrong")
        }
    }
}






