import UIKit
import Combine

struct Movies: Codable {
    let search: [Search]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct Search: Codable {
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
    }
}

func fetchMovies(for searchTerm: String) -> AnyPublisher<Movies, Error> {
    let url = URL(string: "https://www.omdbapi.com/?s=\(searchTerm)&page=2&apikey=7fbb5b35")!
    return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: Movies.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

var cancellables: Set<AnyCancellable> = []

Publishers.CombineLatest(fetchMovies(for: "Batman"), fetchMovies(for: "Spiderman"))
    .sink { completion in
        
    } receiveValue: { value1, value2 in
        print(value1.search)
        print(value2.search)
    }.store(in: &cancellables)

