//
//  File.swift
//  
//
//  Created by Erik Flores on 29/3/21.
//

import XCTest
import Combine
@testable import RickAndMortyAPI

final class LocationTests: XCTestCase {
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
    
    func testLocationURLWithID() {
        let locationURL = API.Endpoint.location("1").url
        XCTAssertEqual(locationURL, "https://rickandmortyapi.com/api/location/1")
    }
    
    func testLocationURL() {
        let locationURL = API.Endpoint.location("").url
        XCTAssertEqual(locationURL, "https://rickandmortyapi.com/api/location/")
    }

    func testLocations() {
        setRequest(forStub: "Locations", withStatusCode: 200)
        
        let expectation = XCTestExpectation(description: "Location result")
        let locations = rickAndMortyApi
            .getLocation()
            .map { $0.results }
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { locations in
                XCTAssertEqual(locations.count, 20)
            }

        XCTAssertNotNil(locations)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testLocationsFailed() {
        setRequest(forStub: "Locations", withStatusCode: 500)
        
        let expectation = XCTestExpectation(description: "Location result failed")
        let locations = rickAndMortyApi
            .getLocation()
            .map { $0.results }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, API.APIError.url.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { _ in }
        
        XCTAssertNotNil(locations)
        wait(for: [expectation], timeout: 5.0)
    }

    func testSingleLocation() {
        setRequest(forStub: "Location", withStatusCode: 200)
        
        let expectation = XCTestExpectation(description: "Location result")
        let location = rickAndMortyApi
            .getLocation(id: "1")
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { location in
                XCTAssertEqual(location.id, 1)
            }

        XCTAssertNotNil(location)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSingleLocationFailed() {
        setRequest(forStub: "Location", withStatusCode: 500)
        
        let expectation = XCTestExpectation(description: "Location result failed")
        let location = rickAndMortyApi
            .getLocation(id: "1")
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, API.APIError.url.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { _ in }
        
        XCTAssertNotNil(location)
        wait(for: [expectation], timeout: 5.0)
    }

}
