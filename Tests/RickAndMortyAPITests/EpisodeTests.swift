//
//  File.swift
//  
//
//  Created by Erik Flores on 29/3/21.
//

import XCTest
import Combine
@testable import RickAndMortyAPI

final class EpisodeTests: XCTestCase {
    let rickAndMortyApi = RickAndMortyAPI()

    func testEpisodes() {
        let expectation = XCTestExpectation(description: "Episode result")
        let episodes = rickAndMortyApi
            .getEpisode()
            .map { $0.results }
            .sink { completion in
                switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                }
            } receiveValue: { episodes in
                XCTAssertEqual(episodes.count, 20)
            }

        XCTAssertNotNil(episodes)
        wait(for: [expectation], timeout: 5.0)
    }

    func testSingleEpisode() {
        let expectation = XCTestExpectation(description: "Episode result")
        let episode = rickAndMortyApi
            .getEpisode(id: "1")
            .sink { completion in
                switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                }
            } receiveValue: { episode in
                XCTAssertEqual(episode.id, 1)
            }

        XCTAssertNotNil(episode)
        wait(for: [expectation], timeout: 5.0)
    }

}
