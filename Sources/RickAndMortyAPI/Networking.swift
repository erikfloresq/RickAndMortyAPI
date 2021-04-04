//
//  File.swift
//  
//
//  Created by Erik Flores on 28/3/21.
//

import Foundation
import Combine

public protocol Networkable {
    func getData<T: Codable>(from url: String) -> AnyPublisher<T, Error>
}

public struct Networking: Networkable {
    private let urlSession: URLSession

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

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
