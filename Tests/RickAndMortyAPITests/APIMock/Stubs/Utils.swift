//
//  File.swift
//  
//
//  Created by Erik Flores on 1/4/21.
//
import Foundation

class Utils {
    func loadStub(from file: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let jsonFileURL = bundle.url(forResource: file, withExtension: "json") else {
            fatalError("Problems with JSON URL")
        }
        do {
            return try Data(contentsOf: jsonFileURL)
        } catch {
            fatalError("Data parse error: \(error.localizedDescription)")
        }
    }
}
