//
//  File.swift
//  
//
//  Created by Erik Flores on 11/1/20.
//

import Foundation

public struct Location: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let type: String
    public let dimension: String
    public let residents: [String]
    public let url: String
    public let created: String
}
