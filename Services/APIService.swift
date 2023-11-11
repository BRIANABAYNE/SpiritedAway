//
//  APIService.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation

protocol APIDataProvidable {
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkingError>) -> Void)
}

extension APIDataProvidable {
    /// Extention of the `APIDataProvidable` protocol
    ///
    /// This is used to provide a default implementaion of the `.perform(_ request: URLRequest)` protocol method.
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkingError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("Completed with a response of", response.statusCode)
            }
            guard let data else {
                completion(.failure(.noData)); return
            }
            completion(.success(data))
        }.resume()
    }
}
