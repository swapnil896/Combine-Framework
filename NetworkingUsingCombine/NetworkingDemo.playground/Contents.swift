import UIKit
import Combine

// Response Model
struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

//======================================= API Call ============================================================
// API Call having return type as AnyPublisher (Abstract and not concrete publisher)
func fetchPosts() -> AnyPublisher<[Post], Error> {
    
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    return URLSession.shared.dataTaskPublisher(for: url) // Returns a publisher
        .map(\.data)                                     // get the data part using map
        .decode(type: [Post].self, decoder: JSONDecoder()) // decode to [Post]
        .receive(on: DispatchQueue.main)               // Receive the data on main thread
        .eraseToAnyPublisher()                         // Erases to AnyPublisher (abstract) instead of a concrete publisher type
}

var cancellables: Set<AnyCancellable> = []

fetchPosts()
    .sink { completion in
        switch completion {
        case .finished:
            print("Update UI")
        case .failure(let error):
            print("Error: \(error)")
        }
    } receiveValue: { posts in
        print(posts)
    }.store(in: &cancellables)


//======================================= API Call - With Error handling & retry =================================
enum NetworkError: Error {
    case badRequest
}

func fetchPostsWithErrorHandling() -> AnyPublisher<[Post], Error> {
    let url = URL(string: "https://jsonplaceholder.typicode.com/postsss")!
    return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { data, response in
            print("Retries")
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkError.badRequest
                  }
            return data
        }
        .decode(type: [Post].self, decoder: JSONDecoder())
        .retry(3)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

fetchPostsWithErrorHandling()
    .sink { completion in
        switch completion {
        case .finished:
            print("Update the UI")
        case .failure(let error):
            print(error)
        }
    } receiveValue: { posts in
        print(posts)
    }.store(in: &cancellables)

/*
 OUTPUT :-
 
 Retries
 Retries
 Retries
 Retries
 badRequest
 */
