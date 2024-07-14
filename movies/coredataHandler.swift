//
//  coredataHandler.swift
//  movies
//
//  Created by Jay on 14/07/24.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MovieModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
    func saveMovie(movieData: MovieData) {
        let context = persistentContainer.viewContext
        let movie = Movie(context: context)
        movie.id = Int64(movieData.id!)
        movie.title = movieData.title
        movie.overview = movieData.overview
        movie.releaseDate = movieData.release_date
        movie.posterPath = movieData.poster_path
        movie.voteAverage = "\(movieData.vote_average ?? 0)"
        
        do {
            try context.save()
        } catch {
            print("Failed to save movie: \(error)")
        }
    }
    
    func fetchMovies() -> [Movie] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch movies: \(error)")
            return []
        }
    }
}
