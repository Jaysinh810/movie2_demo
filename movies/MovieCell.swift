//
//  MovieCell.swift
//  movies
//
//  Created by Jay on 14/07/24.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var movietitleLbl: UILabel!
    @IBOutlet weak var moviegenreLbl: UILabel!
    @IBOutlet weak var moviedateLbl: UILabel!
    
    @IBOutlet weak var movieratingView: RatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.movieratingView.rating = 3
        self.movieratingView.ratingCount = 3
        self.movieratingView.layer.masksToBounds = true
        self.movieratingView.layer.cornerRadius = 5
        self.movieratingView.backgroundColor = UIColor(red: 25/265, green: 25/265, blue: 39/265, alpha: 1)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(movieid:Int, movietitle:String, movieimg:String, moviedate:String, movierating:Double) {
        print("=> ID", movieid)
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movieimg)")
        //KF
        self.movietitleLbl.text = movietitle
        self.moviedateLbl.text = moviedate
        self.movieratingView.ratingCount = Int(movierating)
    }
    

}
