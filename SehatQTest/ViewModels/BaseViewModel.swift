//
//  BaseViewModel.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import Foundation

class BaseViewModel {
    
    let api = CoreApi()
    
    init() {
        api.delegate = self
    }
}

extension BaseViewModel: CoreApiDelegate {
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
    }
    
    func failed(interFace: CoreApi, result: AnyObject) {
    }
}
