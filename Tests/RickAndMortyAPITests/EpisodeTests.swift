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
    
    func testEpisodeURLWithID() {
        let episodeURL = API.Endpoint.episode("1").url
        XCTAssertEqual(episodeURL, "https://rickandmortyapi.com/api/episode/1")
    }
    
    func testEpisodeURL() {
        let episodeURL = API.Endpoint.episode("").url
        XCTAssertEqual(episodeURL, "https://rickandmortyapi.com/api/episode/")
    }

    func testEpisodes() {
        setRequest(forStub: "Episodes", withStatusCode: 200)
        
        let expectation = XCTestExpectation(description: "Episode result")
        let episodes = rickAndMortyApi
            .getEpisode()
            .map { $0.results }
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { episodes in
                XCTAssertEqual(episodes.count, 20)
            }

        XCTAssertNotNil(episodes)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testEpisodesFailed() {
        setRequest(forStub: "Episodes", withStatusCode: 500)
        
        let expectation = XCTestExpectation(description: "Episode result failed")
        let episodes = rickAndMortyApi
            .getEpisode()
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
        
        XCTAssertNotNil(episodes)
        wait(for: [expectation], timeout: 5.0)
    }

    func testSingleEpisode() {
        setRequest(forStub: "Episode", withStatusCode: 200)
        
        let expectation = XCTestExpectation(description: "Episode result")
        let episode = rickAndMortyApi
            .getEpisode(id: "1")
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { episode in
                XCTAssertEqual(episode.id, 1)
            }

        XCTAssertNotNil(episode)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSingleEpisodeFailed() {
        setRequest(forStub: "Episode", withStatusCode: 500)
        
        let expectation = XCTestExpectation(description: "Episode result failed")
        let episode = rickAndMortyApi
            .getEpisode(id: "1")
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, API.APIError.failureRequest.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { _ in }
        
        XCTAssertNotNil(episode)
        wait(for: [expectation], timeout: 5.0)
    }

}

@available(iOS 15, *)
extension EpisodeTests {
    func testEpisodesAsync() async {
        setRequest(forStub: "Episodes", withStatusCode: 200)
        do {
            let episodes = try await rickAndMortyApi.getEpisode()
            XCTAssertEqual(episodes.results.count, 20)
        } catch {
            XCTFail("Expected episodes, but failed \(error)")
        }
    }

    func testEpisodesFailedAsync() async {
        setRequest(forStub: "Episodes", withStatusCode: 500)
        do {
            let _ = try await rickAndMortyApi.getEpisode()
        } catch {
            XCTAssertEqual(error.localizedDescription, API.APIError.failureRequest.localizedDescription)
        }
    }

    func testSingleEpisodeAsync() async {
        setRequest(forStub: "Episode", withStatusCode: 200)
        do {
            let episode = try await rickAndMortyApi.getEpisode(id: "1")
            XCTAssertEqual(episode.id, 1)
        } catch {
            XCTFail("Expected episode, but failed \(error)")
        }
    }

    func testSingleEpisodeFailedAsync() async {
        setRequest(forStub: "Episode", withStatusCode: 500)
        do {
            let _ = try await rickAndMortyApi.getEpisode(id: "1")
        } catch {
            XCTAssertEqual(error.localizedDescription, API.APIError.failureRequest.localizedDescription)
        }
    }
}
