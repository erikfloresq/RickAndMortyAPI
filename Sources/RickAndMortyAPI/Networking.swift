//
//  File.swift
//  
//
//  Created by Erik Flores on 28/3/21.
//

import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, *)
struct Networking {
    private let urlSession = URLSession.shared

    func getData<T: Codable>(from url: String,
            _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error>{
        let url = URL(string: url)!
        let dataTask = urlSession.dataTaskPublisher(for: url)
        return dataTask
                .tryMap { result -> T in
                    guard let httpResponse = result.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                            throw API.APIError.url
                          }
                    return try decoder.decode(T.self, from: result.data)
                }
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
    }
}
