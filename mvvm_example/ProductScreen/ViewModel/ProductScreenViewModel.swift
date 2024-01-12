//
//  ProductScreenViewModel.swift
//  mvvm_example
//
//  Created by Tanmay Chandra Nath on 12/01/24.
//

import Foundation

class ProductScreenViewModel {
    var products: [ProductModel] = []
    var apiHelper: ApiHelperProtocol?
    
    func getProducts() {
        guard let apiHelper = apiHelper else { return }
        apiHelper.fetchProduct { response in
            switch response {
            case .success(let products): self.products = products
            case .failure(let error):
                print(error)
            }
        }
    }
}
