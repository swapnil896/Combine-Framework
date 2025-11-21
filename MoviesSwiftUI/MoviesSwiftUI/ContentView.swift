//
//  ContentView.swift
//  MoviesSwiftUI
//
//  Created by Swapnil Magar on 21/11/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var movies: [Movie] = []
    @State private var search: String = ""
    @State private var cancellables: Set<AnyCancellable> = []
    
    private var searchSubject = CurrentValueSubject<String, Never>("")
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    private func setupSearchPublisher() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { searchValue in
                self.loadMovies(for: searchValue)
            }.store(in: &cancellables)
    }
    
    private func loadMovies(for searchTerm: String) {
        httpClient.fetchMovies(search: searchTerm)
            .sink { _ in
                
            } receiveValue: { movies in
                self.movies = movies
            }.store(in: &cancellables)

    }
    
    var body: some View {
        NavigationStack {
            List(movies) { movie in
                HStack {
                    AsyncImage(url: movie.poster) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(movie.title)
                }
                
            }
            .navigationTitle("Movies")
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Movies")
        }
        
        .onAppear(perform: {
            if cancellables.isEmpty {
                setupSearchPublisher()
            }
        })
        .onChange(of: search) {
                searchSubject.send(search)
            }
    }
}

#Preview {
    ContentView(httpClient: HTTPClient())
}
