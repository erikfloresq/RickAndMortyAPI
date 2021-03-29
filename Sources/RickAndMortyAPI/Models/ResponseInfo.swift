//
//  File.swift
//  
//
//  Created by Erik Flores on 11/1/20.
//

import Foundation

struct ResponseInfo: Codable {
    let count: Int
    let pages: Int
    let next: String
    let prev: String?
}
