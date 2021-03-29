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
    let rickAndMortyApi = RickAndMortyAPI()

    func testLocations() {
        let expectation = XCTestExpectation(description: "Location result")
        let locations = rickAndMortyApi
            .getLocation()
            .map { $0.results }
            .sink { completion in
                switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                }
            } receiveValue: { locations in
                XCTAssertEqual(locations.count, 20)
            }

        XCTAssertNotNil(locations)
        wait(for: [expectation], timeout: 5.0)
    }

    func testSingleLocation() {
        let expectation = XCTestExpectation(description: "Location result")
        let location = rickAndMortyApi
            .getLocation(id: "1")
            .sink { completion in
                switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                }
            } receiveValue: { location in
                XCTAssertEqual(location.id, 1)
            }

        XCTAssertNotNil(location)
        wait(for: [expectation], timeout: 5.0)
    }

}
