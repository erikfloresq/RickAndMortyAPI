//
//  File.swift
//  
//
//  Created by Erik Flores on 14/6/21.
//

import Foundation

@available(iOS 15, *)
public protocol NetworkableAsync {
    func getData<T: Codable>(from url: String) async throws -> T
}

@available(iOS 15, *)
public struct NetworkingAsync: NetworkableAsync {
    private let urlSession: URLSession

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    public func getData<T: Codable>(from url: String) async throws -> T {
        let url = URL(string: url)!
        let (data, response) = try await urlSession.data(from: url)
        guard let response = response as? HTTPURLResponse,
              response.statusCode != 200 else {
                  throw API.APIError.failureRequest
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
