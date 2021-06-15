//
//  File.swift
//  
//
//  Created by Erik Flores on 28/3/21.
//

import Foundation
import Combine

public struct Networking {
    private let urlSession: URLSession

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension Networking {
    public func getData<T: Codable>(from url: String) -> AnyPublisher<T, Error> {
        let url = URL(string: url)!
        let dataTask = urlSession.dataTaskPublisher(for: url)
        return dataTask
                .tryMap { result -> T in
                    guard let httpResponse = result.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                            throw API.APIError.url
                          }
                    return try JSONDecoder().decode(T.self, from: result.data)
                }
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
    }
}

@available(iOS 15, *)
extension Networking {
    public func data<T: Codable>(from url: String) async throws -> T {
        let url = URL(string: url)!
        let (data, response) = try await urlSession.data(from: url)
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
                  throw API.APIError.failureRequest
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
