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
    var urlSession: URLSession!
    var networking: Networking!
    var rickAndMortyApi: RickAndMortyAPI!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        networking = Networking(urlSession: urlSession)
        rickAndMortyApi = RickAndMortyAPI(networking: networking)
    }
    
    func setRequest(forStub stub: String, withStatusCode statusCode: Int) {
        MockURLProtocol.requestHandler = { request in
            let url = URL(string: "https://rickandmorty.mock")!
            let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
            let charactersData = Utils().loadStub(from: stub)
            return (response, charactersData)
        }
    }
    
    func testCharacterURLWithID() {
        let characterURL = API.Endpoint.character("1").url
        XCTAssertEqual(characterURL, "https://rickandmortyapi.com/api/character/1")
    }
    
    func testCharacterURL() {
        let characterURL = API.Endpoint.character("").url
        XCTAssertEqual(characterURL, "https://rickandmortyapi.com/api/character/")
    }

    func testCharacters() throws {
        setRequest(forStub: "Characters", withStatusCode: 200)
        
        let expectation = XCTestExpectation(description: "Character result")
        let characters = rickAndMortyApi
            .getCharacter()
            .map { $0.results }
            .sink { _ in
                    expectation.fulfill()
                  }
                  receiveValue: { characters in
                    XCTAssertEqual(characters.count, 20)
                  }

        XCTAssertNotNil(characters)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCharactersFailed() throws {
        setRequest(forStub: "Characters", withStatusCode: 500)
        
        let expectation = XCTestExpectation(description: "Character result failed")
        let characters = rickAndMortyApi
            .getCharacter()
            .map { $0.results }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, API.APIError.failureRequest.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { _ in }
        
        XCTAssertNotNil(characters)
        wait(for: [expectation], timeout: 5.0)
    }

    func testSingleCharacter() {
        setRequest(forStub: "Character", withStatusCode: 200)
        
        let expectation = XCTestExpectation(description: "Single character result")
        let character = rickAndMortyApi
            .getCharacter(id: "1")
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { character in
                XCTAssertEqual(character.id, 1)
            }

        XCTAssertNotNil(character)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSingleCharacterFailed() {
        setRequest(forStub: "Character", withStatusCode: 500)
        
        let expectation = XCTestExpectation(description: "Single character result failed")
        let character = rickAndMortyApi
            .getCharacter(id: "1")
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, API.APIError.failureRequest.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { _ in }
        
        XCTAssertNotNil(character)
        wait(for: [expectation], timeout: 5.0)
    }
    
}

@available(iOS 15, *)
extension CharacterTests {

    func testCharactersAsync() async {
        setRequest(forStub: "Characters", withStatusCode: 200)
        do {
            let characters = try await rickAndMortyApi.getCharacter()
            XCTAssertEqual(characters.results.count, 20)
        } catch {
            XCTFail("Expected charactes, but failed \(error)")
        }

    }

    func testCharactersFailedAsync() async {
        setRequest(forStub: "Characters", withStatusCode: 500)
        do {
            let _ = try await rickAndMortyApi.getCharacter()
        } catch(let error) {
            XCTAssertEqual(error.localizedDescription, API.APIError.failureRequest.localizedDescription)
        }
    }

    func testSingleCharacterAsync() async {
        setRequest(forStub: "Character", withStatusCode: 200)
        do {
            let character = try await rickAndMortyApi.getCharacter(id: "1")
            XCTAssertEqual(character.name, "Rick Sanchez")
        } catch {
            XCTFail("Expected characte, but failed \(error)")
        }
    }

    func testSingleCharacterFailedAsync() async {
        setRequest(forStub: "Character", withStatusCode: 500)
        do {
            let _ = try await rickAndMortyApi.getCharacter(id: "1")
        } catch {
            XCTAssertEqual(error.localizedDescription, API.APIError.failureRequest.localizedDescription)
        }
    }

}
