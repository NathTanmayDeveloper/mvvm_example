//
//  ApiHelper.swift
//  mvvm_example
//
//  Created by Tanmay Chandra Nath on 13/01/24.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case error(_ error: Error)
}

protocol ApiHelperProtocol: AnyObject {
    func fetchProduct(completion: @escaping (Result<[ProductModel], ApiError>) -> ())
}

class ServiceManager: ApiHelperProtocol {
    
    func fetchProduct(completion: @escaping (Result<[ProductModel], ApiError>) -> ()) {
        let url = URL(string: UrlConstants.productsUrl)
        guard let url = url else {
            completion(.failure(.invalidUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard error != nil else {
                completion(.failure(.error(error!)))
                return
            }
            do {
                let products = try JSONDecoder().decode([ProductModel].self, from: data)
                completion(.success(products))
            } catch(let error) {
                completion(.failure(.error(error)))
            }
        }
    }
    
}
