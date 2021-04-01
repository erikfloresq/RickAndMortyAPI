//
//  File.swift
//  
//
//  Created by Erik Flores on 29/3/21.
//

import XCTest
import Combine
import Foundation
@testable import RickAndMortyAPI

final class CharacterTests: XCTestCase {
    let rickAndMortyApi = RickAndMortyAPI()
    let rickAndMortyApiMock = RickAndMortyAPIMock()

    func testCharacters() {
        let expectation = XCTestExpectation(description: "Character result")
        let characters = rickAndMortyApiMock
            .getCharacter()
            .map { $0.results }
            .sink { completion in
                switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                        expectation.fulfill()
                }
            } receiveValue: { characters in
                XCTAssertEqual(characters.count, 20)
            }

        XCTAssertNotNil(characters)
        wait(for: [expectation], timeout: 5.0)
    }

    func testCharacterURLWithID() {
        let characterURL = API.Endpoint.character("1").url
        XCTAssertEqual(characterURL, "https://rickandmortyapi.com/api/character/1")
    }

    func testCharacterURL() {
        let characterURL = API.Endpoint.character("").url
        XCTAssertEqual(characterURL, "https://rickandmortyapi.com/api/character/")
    }

    func testSingleCharacter() {
        let expectation = XCTestExpectation(description: "Single character result")
        let character = rickAndMortyApi
            .getCharacter(id: "1")
            .sink { completion in
                switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                        expectation.fulfill()
                }
            } receiveValue: { character in
                XCTAssertEqual(character.id, 1)
            }

        XCTAssertNotNil(character)
        wait(for: [expectation], timeout: 5.0)
    }
    
}
