import Foundation
import Combine

/// Provide characters, locations and episodes of RickAndMortyAPI
public struct RickAndMortyAPI {
    private let networking: Networking

    public init(networking: Networking = Networking()) {
        self.networking = networking
    }
}

public extension RickAndMortyAPI {
    /// Get the first 20 Characters with publisher
    func getCharacter() -> AnyPublisher<ResponseAPI<Character>, Error> {
        networking.getData(from: API.Endpoint.character("").url)
    }

    /// Get a Character with id with publisher
    func getCharacter(id: String) -> AnyPublisher<Character, Error> {
        networking.getData(from: API.Endpoint.character(id).url)
    }

    /// Get the first 20 Episodes with publisher
    func getEpisode() -> AnyPublisher<ResponseAPI<Episode>, Error> {
        networking.getData(from: API.Endpoint.episode("").url)
    }

    /// Get a Episodes with id with publisher
    func getEpisode(id: String) -> AnyPublisher<Episode, Error> {
        networking.getData(from: API.Endpoint.episode(id).url)
    }

    /// Get the first 20 Locations with publisher
    func getLocation() -> AnyPublisher<ResponseAPI<Location>, Error> {
        networking.getData(from: API.Endpoint.location("").url)
    }

    /// Get a Location with id with publisher
    func getLocation(id: String) -> AnyPublisher<Location, Error> {
        networking.getData(from: API.Endpoint.location(id).url)
    }
}

@available(iOS 15, *)
public extension RickAndMortyAPI {
    /// Get the first 20 Characters with async/await
    func getCharacter() async throws -> ResponseAPI<Character> {
        try await networking.data(from: API.Endpoint.character("").url)
    }

    /// Get a Character with id with async/await
    func getCharacter(id: String) async throws -> Character {
        try await networking.data(from: API.Endpoint.character(id).url)
    }

    /// Get the first 20 Episodes with async/await
    func getEpisode()  async throws -> ResponseAPI<Episode> {
        try await networking.data(from: API.Endpoint.episode("").url)
    }

    /// Get a Episodes with id with async/await
    func getEpisode(id: String) async throws -> Episode {
        try await networking.data(from: API.Endpoint.episode(id).url)
    }

    /// Get the first 20 Locations with async/await
    func getLocation() async throws -> ResponseAPI<Location> {
        try await networking.data(from: API.Endpoint.location("").url)
    }

    /// Get a Location with id with async/await
    func getLocation(id: String) async throws -> Location {
        try await networking.data(from: API.Endpoint.location(id).url)
    }
}
