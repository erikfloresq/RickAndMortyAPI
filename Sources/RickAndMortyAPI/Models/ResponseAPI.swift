//
//  File.swift
//  
//
//  Created by Erik Flores on 11/1/20.
//

import Foundation

struct ResponseAPI<T: Codable>: Codable {
    let info: ResponseInfo
    let results: [T]
}
