//
//  MovieDetailsViewController.swift
//  flix
//
//  Created by Alyssa Davis on 9/6/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(movie)
        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w1280" + backdropPath)!
        let posterUrl = URL(string: baseUrl + posterPath)!
        posterView.isUserInteractionEnabled = true
        backdropView.af.setImage(withURL: backdropUrl)
        posterView.af.setImage(withURL: posterUrl)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsViewController = segue.destination as! MovieTrailerViewController
        let id = movie["id"]
        var urlString = "https://api.themoviedb.org/3/movie/";
        urlString += "\(id!)";
        urlString += "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
        detailsViewController.movieURL = URL(string: urlString)!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
