//
//  File.swift
//  
//
//  Created by Erik Flores on 11/1/20.
//

import Foundation

struct Character: Codable {
    struct Origin: Codable {
        let name: String
        let url: String
    }
    
    struct Location: Codable {
        let name: String
        let url: String
    }
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
