import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, *)
struct RickAndMortyAPI {
    let networking = Networking()

    func getCharacter() -> AnyPublisher<ResponseAPI<Character>, Error> {
        networking.getData(from: API.Endpoint.character("").url)
    }

    func getCharacter(id: String) -> AnyPublisher<Character, Error> {
        networking.getData(from: API.Endpoint.character(id).url)
    }

    func getEpisode() -> AnyPublisher<ResponseAPI<Episode>, Error> {
        networking.getData(from: API.Endpoint.episode("").url)
    }

    func getEpisode(id: String) -> AnyPublisher<Episode, Error> {
        networking.getData(from: API.Endpoint.episode(id).url)
    }

    func getLocation() -> AnyPublisher<ResponseAPI<Location>, Error> {
        networking.getData(from: API.Endpoint.location("").url)
    }

    func getLocation(id: String) -> AnyPublisher<Location, Error> {
        networking.getData(from: API.Endpoint.location(id).url)
    }
}
