//
//  ProductScreenViewModel.swift
//  mvvm_example
//
//  Created by Tanmay Chandra Nath on 12/01/24.
//

import Foundation

class ProductScreenViewModel {
    var products: [ProductModel] = []
    let apiHelper: ApiHelperProtocol
    
    init(apiHelper: ApiHelperProtocol) {
        self.apiHelper = apiHelper
    }
    
    func getProducts() {
        apiHelper.fetchProduct { response in
            switch response {
            case .success(let products): self.products = products
            case .failure(let error):
                print(error)
            }
        }
    }
}
