//
//  APIService.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation

/// An abstraction of the `URLSession.shared.DataTask` closure.
/// ```
/// func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkingError>) -> Void)
/// ```
///
/// - Parameters
///   - request: A URL request object that provides the URL, cache policy, request type, body data or body stream, and so on.
///   - completion: The completion handler to call when the `dataTask` request is complete. This completion handler takes the following  `ResultType` parameters:
///     - Data: The data returned by the server.
///     - NetworkingError: A custom error type
///
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
