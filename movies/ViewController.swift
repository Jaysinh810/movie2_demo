//
//  ViewController.swift
//  movies
//
//  Created by Jay on 14/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: ------------------------- IBOUTLETS -------------------------
    
    @IBOutlet weak var movieTableView: UITableView!
    
    var movies: [Movie] = []
    var currentPage = 1
    var totalPages = 1
    
    //MARK: ------------------------- VIEWDIDLOAD -------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        
        fetchMovies(page: currentPage)
    }
    
    
    //MARK: ------------------------- IBACTIONS -------------------------
    
    
    
    
    //MARK: ------------------------- FUNCTIONS -------------------------
    
    func fetchMovies(page: Int) {
        //API CALL
        let apistring = "https://api.themoviedb.org/3/movie/now_playing?api_key=eac1991f504e08d0d5804d05c901787e&language=en-US&page=1"
        guard let url = URL(string: apistring) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let movieResp = try JSONDecoder().decode(movieModel.self, from: data)
                self?.totalPages = movieResp.total_pages!
                
                for movieData in movieResp.results ?? [] {
                    CoreDataManager.shared.saveMovie(movieData: movieData)
                }
                
                DispatchQueue.main.async {
                    self?.movies.append(contentsOf: CoreDataManager.shared.fetchMovies())
                    self?.movieTableView.reloadData()
                }
            }
            catch {
                print("==", error.localizedDescription)
            }
            
        }.resume()
        
    }
    
    
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.setData(movieid: Int(movie.id), movietitle: movie.title!, movieimg: movie.posterPath!, moviedate: movie.releaseDate!, movierating: Double(movie.voteAverage!)!)
        
        if indexPath.row == movies.count - 1 && currentPage < totalPages {
            currentPage += 1
            fetchMovies(page: currentPage)
        }
        
        
        return cell
    }
    
    
}

