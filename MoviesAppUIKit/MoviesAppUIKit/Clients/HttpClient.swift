//
//  HttpClient.swift
//  MoviesAppUIKit
//
//  Created by Swapnil Magar on 21/11/25.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badURL
}

class HttpClient {
    
    func fetchMovies(searchTerm: String) -> AnyPublisher<[Movie], Error> {
        guard let encodedSearch = searchTerm.urlEncoded, let url = URL(string: "https://www.omdbapi.com/?s=\(encodedSearch)&page=2&apikey=7fbb5b35") else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map(\.search)
            .receive(on: DispatchQueue.main)
            .catch({ error -> AnyPublisher<[Movie], Error> in
                // If any of the upstream fails, then catch block is invoked
                // Here, as our return type is AnyPublisher<[Movie], Error>, we need to return the same sort of error from here as well
                // So, Just([]) will give a Just publisher with empty array and Never error --> Output : [], Failure: Never
                // This does not match our return type
                // So, we setFailtureType of this Just publisher from Never to Error.self, to match our return type
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            })
            .eraseToAnyPublisher()
    }
}
