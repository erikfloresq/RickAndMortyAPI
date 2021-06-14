//
//  File.swift
//  
//
//  Created by Erik Flores on 14/6/21.
//

import Foundation
import XCTest
@testable import RickAndMortyAPI

final class CharacterAsyncTest: XCTest {
    var urlSession: URLSession!
    var networkingAsync: NetworkingAsync!
    var rickAndMortyApiAsync: RickAndMortyAPIAsync!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        networkingAsync = NetworkingAsync(urlSession: urlSession)
        rickAndMortyApiAsync = RickAndMortyAPIAsync(networkingAsync: networkingAsync)
    }

    func setRequest(forStub stub: String, withStatusCode statusCode: Int) {
        MockURLProtocol.requestHandler = { request in
            let url = URL(string: "https://rickandmorty.mock")!
            let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
            let charactersData = Utils().loadStub(from: stub)
            return (response, charactersData)
        }
    }

    func getCharacter() {
        
    }
}
