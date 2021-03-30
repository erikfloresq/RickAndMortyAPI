//
//  File.swift
//  
//
//  Created by Erik Flores on 11/1/20.
//

import Foundation

public struct ResponseInfo: Codable {
    public let count: Int
    public let pages: Int
    public let next: String
    public let prev: String?
}
