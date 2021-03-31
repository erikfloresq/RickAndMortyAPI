import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, *)
/// Provide characters, locations and episodes of RickAndMortyAPI
public struct RickAndMortyAPI {
    private let networking = Networking()

    public init() {}

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
