////
////  model.swift
////  movies
////
////  Created by Jay on 14/07/24.
////
//
//import Foundation
//
//struct MovieResponse: Codable {
//    let results: [MovieData]
//    let totalPages: Int
//    let totalResults: Int
//}
//
//struct MovieData: Codable {
//    let id: Int
//    let title: String
//    let overview: String
//    let releaseDate: String
//    let posterPath: String
//    let voteAverage: String
//    
//    enum CodingKeys: String, CodingKey {
//        case id, title, overview
//        case releaseDate = "release_date"
//        case posterPath = "poster_path"
//        case voteAverage = "vote_average"
//    }
//}
