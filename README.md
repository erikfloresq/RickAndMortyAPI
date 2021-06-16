# RickAndMortyAPI

Swift wrapper for [RickandMortyAPI](https://rickandmortyapi.com)
I coded this wrapper with combine

## Quick look of methods

### Character

`getCharacter() -> AnyPublisher<ResponseAPI<Character>, Error>`

`getCharacter() async throws -> ResponseAPI<Character>`

`getCharacter(id: String) -> AnyPublisher<Character, Error>`

`getCharacter(id: String) async throws -> Character`

### Episode

`getEpisode() -> AnyPublisher<ResponseAPI<Episode>, Error>`

`getEpisode() async throws -> ResponseAPI<Episode>`

`getEpisode(id: String) -> AnyPublisher<Episode, Error>`

`getEpisode(id: String) async throws -> Episode`

### Location

`getLocation() -> AnyPublisher<ResponseAPI<Location>, Error>`

`getLocation() async throws -> ResponseAPI<Location>`

`getLocation(id: String) -> AnyPublisher<Location, Error>`

`getLocation(id: String) async throws -> Location`


## Example

**For async await**

```
class ViewModel {
    enum ApiError: Error {
        case failureRequest
    }
    
    let rickAndMortyAPI = RickAndMortyAPI()

    func getCharacter() async throws -> [Characters] {
        do {
            let characters = try await rickAndMortyAPI.getCharacter()
            return characters.results
        } catch {
            throw ApiError.failureRequest
        }
    }
}
```

**For combine**

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





