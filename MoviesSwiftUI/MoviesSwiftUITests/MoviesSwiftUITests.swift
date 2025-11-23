//
//  MoviesSwiftUITests.swift
//  MoviesSwiftUITests
//
//  Created by Swapnil Magar on 23/11/25.
//

import XCTest
import Combine

final class MoviesSwiftUITests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []
    
    func test_fetch_movies() {
        let httpClient = HTTPClient()
        
        let expectation = XCTestExpectation(description: "Received movies")
        
        httpClient.fetchMovies(search: "Batman")
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    XCTFail("Error in API Call - \(error)")
                }
            } receiveValue: { movies in
                XCTAssertTrue(movies.count > 0)
                expectation.fulfill()
            }.store(in: &cancellables)

    }
}
