//
//  File.swift
//  
//
//  Created by Erik Flores on 28/3/21.
//

import Foundation

struct API {
    static let baseURL = "https://rickandmortyapi.com/api/"
    enum Endpoint {
        case character(String)
        case episode(String)
        case location(String)

        var url: String {
            switch self {
                case .character(let id):
                    return "\(baseURL)character/\(id)"
                case .episode(let id):
                    return "\(baseURL)episode/\(id)"
                case .location(let id):
                    return "\(baseURL)location/\(id)"
            }
        }
    }
    enum APIError: Error {
        case url
    }
}
