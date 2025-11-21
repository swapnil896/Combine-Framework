//
//  MovieListViewModel.swift
//  MoviesSwiftUI
//
//  Created by Swapnil Magar on 21/11/25.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published private(set) var movies: [Movie] = []
    
    private let searchSubject = CurrentValueSubject<String, Never>("")
    private var cancellables: Set<AnyCancellable> = []
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
        setupSearchPublisher()
    }
    
    func setupSearchPublisher() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchValue in
                self?.fetchMovies(searchValue)
            }.store(in: &cancellables)
    }
    
    func fetchMovies(_ searchTerm: String) {
        httpClient.fetchMovies(search: searchTerm)
            .sink { _ in
                
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }.store(in: &cancellables)
    }
}
