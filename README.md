# RickAndMortyAPI

Swift wrapper for [RickandMortyAPI](https://rickandmortyapi.com)
I coded this wrapper with combine

## Quick look of methods

### Character

`getCharacter() -> AnyPublisher<ResponseAPI<Character>, Error>`

`getCharacter(id: String) -> AnyPublisher<Character, Error>`

### Episode

`getEpisode() -> AnyPublisher<ResponseAPI<Episode>, Error>`

`getEpisode(id: String) -> AnyPublisher<Episode, Error>`

### Location

`getLocation() -> AnyPublisher<ResponseAPI<Location>, Error>`


`getLocation(id: String) -> AnyPublisher<Location, Error>`


## Example


```
class ViewModel: ObservableObject {
    let rickAndMortyAPI = RickAndMortyAPI()
    @Published var characters = [Character]()
    var cancellable = Set<AnyCancellable>()

    func getCharacter() {
        rickAndMortyAPI
            .getCharacter()
            .map { $0.results }
            .sink { (completion) in
                print("")
            } receiveValue: { (characters) in
                self.characters = characters
            }.store(in: &cancellable)
    }
}
```





