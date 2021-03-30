import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, *)
public struct RickAndMortyAPI {
    private let networking = Networking()

    public init() {}

    public func getCharacter() -> AnyPublisher<ResponseAPI<Character>, Error> {
        networking.getData(from: API.Endpoint.character("").url)
    }

    public func getCharacter(id: String) -> AnyPublisher<Character, Error> {
        networking.getData(from: API.Endpoint.character(id).url)
    }

    public func getEpisode() -> AnyPublisher<ResponseAPI<Episode>, Error> {
        networking.getData(from: API.Endpoint.episode("").url)
    }

    public func getEpisode(id: String) -> AnyPublisher<Episode, Error> {
        networking.getData(from: API.Endpoint.episode(id).url)
    }

    public func getLocation() -> AnyPublisher<ResponseAPI<Location>, Error> {
        networking.getData(from: API.Endpoint.location("").url)
    }

    public func getLocation(id: String) -> AnyPublisher<Location, Error> {
        networking.getData(from: API.Endpoint.location(id).url)
    }
}
