//
//  MovieListViewModel.swift
//  MoviesAppUIKit
//
//  Created by Swapnil Magar on 21/11/25.
//

import Foundation
import Combine

class MovieListViewModel {
    
    @Published private(set) var movies: [Movie] = []
    @Published var loadingCompleted: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func fetchMovies(for searchTerm: String) {
        httpClient.fetchMovies(searchTerm: searchTerm)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.loadingCompleted = true
                case .failure(let error):
                    print("error: \(error)")
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }.store(in: &cancellables)

    }
}
