//
//  Movie.swift
//  MoviesAppUIKit
//
//  Created by Swapnil Magar on 21/11/25.
//

import Foundation

struct MovieResponse: Decodable {
    let search: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct Movie: Decodable {
    let title: String
    let year: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
    }
}

//=================================================================================================================================
/*
{
  "Search": [
    {
      "Title": "Batman v Superman: Dawn of Justice (Ultimate Edition)",
      "Year": "2016",
      "imdbID": "tt18689424",
      "Type": "movie",
      "Poster": "https://m.media-amazon.com/images/M/MV5BOTRlNWQwM2ItNjkyZC00MGI3LThkYjktZmE5N2FlMzcyNTIyXkEyXkFqcGdeQXVyMTEyNzgwMDUw._V1_SX300.jpg"
    },
    {
      "Title": "Batman: The Killing Joke",
      "Year": "2016",
      "imdbID": "tt4853102",
      "Type": "movie",
      "Poster": "https://m.media-amazon.com/images/M/MV5BMzJiZTJmNGItYTUwNy00ZWE2LWJlMTgtZjJkNzY1OTRiNTZlXkEyXkFqcGc@._V1_SX300.jpg"
    },
*/
