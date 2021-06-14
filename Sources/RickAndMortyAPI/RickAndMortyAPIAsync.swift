//
//  RickAndMortyAPIAsync.swift
//  
//
//  Created by Erik Flores on 14/6/21.
//

import Foundation

protocol RickAndMortyAPIAsyncable {
    func getCharacter() async throws -> Character
    func getCharacter(id: String) async throws -> Character
    func getEpisode()  async throws -> Episode
    func getEpisode(id: String) async throws -> Episode
    func getLocation() async throws -> Location
    func getLocation(id: String) async throws -> Location
}

public actor RickAndMortyAPIAsync: RickAndMortyAPIAsyncable {
    private let networkingAsync: NetworkableAsync

    public init(networkingAsync: NetworkableAsync = NetworkingAsync()) {
        self.networkingAsync = networkingAsync
    }
}

// Async/Await

public extension RickAndMortyAPIAsync {
    /// Get the first 20 Characters with async/await
    func getCharacter() async throws -> Character {
        try await networkingAsync.getData(from: API.Endpoint.character("").url)
    }

    /// Get a Character with id with async/await
    func getCharacter(id: String) async throws -> Character {
        try await networkingAsync.getData(from: API.Endpoint.character(id).url)
    }

    /// Get the first 20 Episodes with async/await
    func getEpisode()  async throws -> Episode {
        try await networkingAsync.getData(from: API.Endpoint.episode("").url)
    }

    /// Get a Episodes with id with async/await
    func getEpisode(id: String) async throws -> Episode {
        try await networkingAsync.getData(from: API.Endpoint.episode(id).url)
    }

    /// Get the first 20 Locations with async/await
    func getLocation() async throws -> Location {
        try await networkingAsync.getData(from: API.Endpoint.location("").url)
    }

    /// Get a Location with id with async/await
    func getLocation(id: String) async throws -> Location {
        try await networkingAsync.getData(from: API.Endpoint.location(id).url)
    }
}
