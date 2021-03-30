//
//  File.swift
//  
//
//  Created by Erik Flores on 11/1/20.
//

import Foundation

public struct Character: Codable, Identifiable {
    public struct Origin: Codable {
        public let name: String
        public let url: String
    }
    
    public struct Location: Codable {
        public let name: String
        public let url: String
    }
    
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: Origin
    public let location: Location
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
}
