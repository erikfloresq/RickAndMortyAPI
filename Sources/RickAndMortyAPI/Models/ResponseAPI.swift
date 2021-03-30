//
//  File.swift
//  
//
//  Created by Erik Flores on 11/1/20.
//

import Foundation

public struct ResponseAPI<T: Codable>: Codable {
    public let info: ResponseInfo
    public let results: [T]
}
