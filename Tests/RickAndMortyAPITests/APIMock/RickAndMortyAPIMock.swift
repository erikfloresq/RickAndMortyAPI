//
//  File.swift
//  
//
//  Created by Erik Flores on 1/4/21.
//

import Foundation
import Combine
@testable import RickAndMortyAPI

struct RickAndMortyAPIMock: RickAndMortyAPIable {
    let utils = Utils()

    func getCharacter() -> AnyPublisher<ResponseAPI<Character>, Error> {
        let charactersData = utils.loadStub(from: "Character")
        let characters = try! JSONDecoder().decode(ResponseAPI<Character>.self, from: charactersData)
        return CurrentValueSubject<ResponseAPI<Character>, Error>(characters).eraseToAnyPublisher()
    }

    func getCharacter(id: String) -> AnyPublisher<Character, Error> {
        let characterData = utils.loadStub(from: "Character")
        let character = try! JSONDecoder().decode(Character.self, from: characterData)
        return CurrentValueSubject<Character, Error>(character).eraseToAnyPublisher()
    }

    func getEpisode() -> AnyPublisher<ResponseAPI<Episode>, Error> {
        let episodesData = utils.loadStub(from: "Episodes")
        let episodes = try! JSONDecoder().decode(ResponseAPI<Episode>.self, from: episodesData)
        return CurrentValueSubject<ResponseAPI<Episode>, Error>(episodes).eraseToAnyPublisher()
    }

    func getEpisode(id: String) -> AnyPublisher<Episode, Error> {
        let episodeData = utils.loadStub(from: "Episode")
        let episode = try! JSONDecoder().decode(Episode.self, from: episodeData)
        return CurrentValueSubject<Episode, Error>(episode).eraseToAnyPublisher()
    }

    func getLocation() -> AnyPublisher<ResponseAPI<Location>, Error> {
        let locationsData = utils.loadStub(from: "Locations")
        let locations = try! JSONDecoder().decode(ResponseAPI<Location>.self, from: locationsData)
        return CurrentValueSubject<ResponseAPI<Location>, Error>(locations).eraseToAnyPublisher()
    }

    func getLocation(id: String) -> AnyPublisher<Location, Error> {
        let locationData = utils.loadStub(from: "Location")
        let locaion = try! JSONDecoder().decode(Location.self, from: locationData)
        return CurrentValueSubject<Location, Error>(locaion).eraseToAnyPublisher()
    }
}
