//
//  MoviesViewController.swift
//  Rotten Tomatoes
//
//  Created by Jonathan Schapiro on 9/24/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl:UIRefreshControl!
    var movies: [NSDictionary] = []
    var filteredMovies: [NSDictionary] = []
  
    
    struct Movie {
        var title:String
        
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let YourApiKey = "nw24bezamtwj4r9rxuwd6d5v" // Fill with the key you registered at http://developer.rottentomatoes.com
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSURLRequest (URL: NSURL(string: RottenTomatoesURLString)!)
        
        var hud = MBProgressHUD(view: self.view)
        self.tableView.addSubview(hud)
        
        hud.labelText = "LOADING"
        hud.show(true)
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            if (error != nil){
                print ("There's an error with the network")
            }
            var errorValue: NSError? = nil
            
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            if (error != nil){
                print ("There's an error")
                
            }
            self.movies = dictionary.valueForKey("movies") as Array
            
           
            
            
            
            self.tableView.reloadData()
            hud.hide(true)
            hud.removeFromSuperview()
            
            self.refreshControl = UIRefreshControl()
            self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
            self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
            self.tableView.addSubview(self.refreshControl)
        })
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as MovieCell
        
        
        
        var movie = movies[indexPath.row]
        
        //print(movieTitles)
        
        
        
        
        cell.titleLabel!.text = movie["title"] as? String
        cell.synopsisLabel!.text = movie["synopsis"] as? String
        
        var poster = movie["posters"] as NSDictionary
        
        var posterURL = poster["original"] as String
        cell.posterView.setImageWithURL(NSURL(string: posterURL))
        
        
        
     

        return cell
        
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowDetail"){
            
            let index = tableView!.indexPathForSelectedRow()!.row
            let detailViewController: MoviesDetailViewController = segue.destinationViewController as MoviesDetailViewController
           
            var movieData = movies[index]
            var movieTitle = movieData["title"] as String
            var movieSynopsis = movieData["synopsis"] as String
            var moviePoster = movieData["posters"] as NSDictionary
            var moviePosterURL = moviePoster["thumbnail"] as String
            moviePosterURL = moviePosterURL.stringByReplacingOccurrencesOfString("tmb", withString: "ori", options: NSStringCompareOptions.LiteralSearch, range: nil)
            var rating = movieData["mpaa_rating"] as String
            var movieRatings = movieData["ratings"] as NSDictionary
            print (movieRatings)
            var movieAudienceRating = movieRatings["audience_score"] as Int
            
            print ("movie rating \(movieAudienceRating)")
            
            
           
            detailViewController.movieTitle = movieTitle
            detailViewController.movieSynopsis = movieSynopsis
            detailViewController.movieURL = moviePosterURL
            
            
            detailViewController.movieAudienceRating = String(movieAudienceRating)
            detailViewController.movieRating = rating
            
  
        }
    }
    
    func refresh(sender:AnyObject){
        self.tableView.reloadData()
        print("data refreshed")
        self.refreshControl.endRefreshing()
    }
    /*
    func filterContentForSearchText(searchText:String){
        
      
            
 
        
    }
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
  */

}
