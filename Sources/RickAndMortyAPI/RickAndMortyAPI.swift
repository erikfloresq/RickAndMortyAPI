import Foundation
import Combine

protocol RickAndMortyAPIable {
    func getCharacter() -> AnyPublisher<ResponseAPI<Character>, Error>
    func getCharacter(id: String) -> AnyPublisher<Character, Error>
    func getEpisode() -> AnyPublisher<ResponseAPI<Episode>, Error>
    func getEpisode(id: String) -> AnyPublisher<Episode, Error>
    func getLocation() -> AnyPublisher<ResponseAPI<Location>, Error>
    func getLocation(id: String) -> AnyPublisher<Location, Error>
}

/// Provide characters, locations and episodes of RickAndMortyAPI
public struct RickAndMortyAPI: RickAndMortyAPIable {
    private let networking: Networkable

    public init(networking: Networkable = Networking()) {
        self.networking = networking
    }

    /// Get the first 20 Characters
    public func getCharacter() -> AnyPublisher<ResponseAPI<Character>, Error> {
        networking.getData(from: API.Endpoint.character("").url)
    }

    /// Get a Character with id
    public func getCharacter(id: String) -> AnyPublisher<Character, Error> {
        networking.getData(from: API.Endpoint.character(id).url)
    }

    /// Get the first 20 Episodes
    public func getEpisode() -> AnyPublisher<ResponseAPI<Episode>, Error> {
        networking.getData(from: API.Endpoint.episode("").url)
    }

    /// Get a Episodes with id
    public func getEpisode(id: String) -> AnyPublisher<Episode, Error> {
        networking.getData(from: API.Endpoint.episode(id).url)
    }

    /// Get the first 20 Locations
    public func getLocation() -> AnyPublisher<ResponseAPI<Location>, Error> {
        networking.getData(from: API.Endpoint.location("").url)
    }

    /// Get a Location with id
    public func getLocation(id: String) -> AnyPublisher<Location, Error> {
        networking.getData(from: API.Endpoint.location(id).url)
    }
}
