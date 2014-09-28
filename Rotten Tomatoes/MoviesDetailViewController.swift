//
//  MoviesDetailViewController.swift
//  Rotten Tomatoes
//
//  Created by Jonathan Schapiro on 9/25/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class MoviesDetailViewController: UIViewController {

    @IBOutlet weak var navigationMovieYearLabel: UILabel!
    @IBOutlet weak var navigationMovieTitle: UINavigationItem!
    
    @IBOutlet weak var navigationPosterView: UIImageView!
    
    @IBOutlet weak var navigationMovieTitleLabel: UILabel!
    
    @IBOutlet weak var navigationSynopsisLabel: UILabel!
    
    
   
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var movieInfoView: UIView!
    
    var movieTitle:String = ""
    var movieSynopsis:String = ""
    var moviePoster:String = ""
    var movieURL:String = ""
    var movieAudienceRating:String = ""
    var movieRating:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print ("initial y position: \(self.movieInfoView.frame.origin.y)")
        self.movieInfoView.frame.origin.y = 600
        navigationMovieTitleLabel.text = movieTitle
        navigationSynopsisLabel.text = movieSynopsis
        navigationPosterView.setImageWithURL(NSURL(string: movieURL))
        navigationPosterView.alpha = 0.7
        navigationMovieYearLabel.text = movieAudienceRating
        rating.text = movieRating
        navigationMovieTitle.title = movieTitle
        
        
       
        
        
        //navigationMovieTitle.description = movieTitle
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
       
        
        
        
        var movieView:CGRect = self.movieInfoView.frame
       
        movieView.origin.y = 360
        
        
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.0)
        UIView.setAnimationDelay(0.5)
        
        self.movieInfoView.frame = movieView
        UIView.commitAnimations()
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
