//
//  ContentView.swift
//  MoviesSwiftUI
//
//  Created by Swapnil Magar on 21/11/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject private var viewModel: MovieListViewModel
    
    init(httpClient: HTTPClient) {
            _viewModel = StateObject(wrappedValue: MovieListViewModel(httpClient: httpClient))
        }
    
    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
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
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Movies")
        }
    }
}

#Preview {
    ContentView(httpClient: HTTPClient())
}
