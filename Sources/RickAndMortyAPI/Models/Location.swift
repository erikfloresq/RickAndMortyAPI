//
//  File.swift
//  
//
//  Created by Erik Flores on 11/1/20.
//

import Foundation

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
