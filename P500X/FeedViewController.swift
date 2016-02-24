//
//  ViewController.swift
//  P500X
//
//  Created by Rupa Sharma on 2/16/16.
//  Copyright © 2016 rupasharma. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var photos = [Photo]()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPhotos = [Photo]()
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotos()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.searchBarStyle = UISearchBarStyle.Minimal
        searchController.searchBar.placeholder = "search titles"
        searchController.searchBar.barTintColor = UIColor.rupaGreen()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table Setup
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredPhotos.count
        }
        return self.photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PhotoTableViewCell
        let photo : Photo
        if searchController.active && searchController.searchBar.text != "" {
            photo = filteredPhotos[indexPath.row]
        } else {
            photo = photos[indexPath.row]
        }
        cell.photo = photo
        return cell
    }
    
    func tableRefresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }

    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let photo : Photo
            if let indexPath = tableView.indexPathForSelectedRow {
                if searchController.active && searchController.searchBar.text != "" {
                    photo = filteredPhotos[indexPath.row]
                } else {
                    photo = photos[indexPath.row]
                }
                
                let controller = segue.destinationViewController as! DetailViewController
                controller.detailPhoto = photo
            }
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredPhotos = photos.filter { photo in
            return photo.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }

    //MARk: - Data calls
    func getPhotos() -> () {
        let url:NSURL = NSURL(string: "https://api.500px.com/v1/photos?feature=popular&consumer_key=vW8Ns53y0F57vkbHeDfe3EsYFCatTJ3BrFlhgV3W")!;
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                if let jsonData = data {
                    do {
                        let jsonResult : NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        if let images = jsonResult["photos"] {
                            for var i = 0; i < images.count; i++ {
                                if let name = images[i]["name"] as? String, imageUrl = images[i]["image_url"] as? String, desc = images[i]["description"] as? String, userPicUrl = images[i]["user"]!!["userpic_https_url"] as? String, username = images[i]["user"]!!["fullname"] as? String {
                                        let newPhoto : Photo = Photo(name: name, fullname: username, description: desc, imageUrl: imageUrl, userImageUrl: userPicUrl)
                                        self.photos.append(newPhoto)
                                        self.tableRefresh()
                                }
                            }
                        }
                    } catch {
                        print("Json Serialization error")
                    }
                }
            }
            
        }
        task.resume()
    }

}

extension FeedViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}