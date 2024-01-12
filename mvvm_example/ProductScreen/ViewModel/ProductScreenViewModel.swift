//
//  ProductScreenViewModel.swift
//  mvvm_example
//
//  Created by Tanmay Chandra Nath on 12/01/24.
//

import Foundation

enum ApiCallEvents {
    case apiCallStarted
    case apiCallFinished
    case gotError(_ error: ApiError)
    case showData
}

typealias ApiEventHandlerType = ((ApiCallEvents) -> ())

class ProductScreenViewModel {
    var products: [ProductModel] = []
    let apiHelper: ApiHelperProtocol
    var eventHanlder: ApiEventHandlerType
    
    init(apiHelper: ApiHelperProtocol, handler: @escaping ApiEventHandlerType) {
        self.apiHelper = apiHelper
        self.eventHanlder = handler
    }
    
    func getProducts() {
        products = []
        eventHanlder(.showData)
        
        eventHanlder(.apiCallStarted)
        apiHelper.fetchProduct { response in
            self.eventHanlder(.apiCallFinished)
            switch response {
            case .success(let products): 
                self.products = products
                self.eventHanlder(.showData)
            case .failure(let error):
                self.eventHanlder(.gotError(error))
            }
        }
    }
}
