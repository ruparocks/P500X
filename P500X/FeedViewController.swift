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
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getPhotos()
//        tableView.reloadData()
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
        return self.photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PhotoTableViewCell
        cell.photo = photos[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: self)
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
            if let indexPath = tableView.indexPathForSelectedRow {
                let photo = photos[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailPhoto = photo
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
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
                                print(images[i])
                                if let name = images[i]["name"] as? String {
                                    if let imageUrl = images[i]["image_url"] as? String {
                                        if let desc = images[i]["description"] as? String {
                                            if let userPicUrl = images[i]["user"]!!["userpic_https_url"] as? String {
                                                if let username = images[i]["user"]!!["fullname"] as? String {
                                                    let newPhoto : Photo = Photo(name: name, fullname: username, description: desc, imageUrl: imageUrl, userImageUrl: userPicUrl)
                                                    self.photos.append(newPhoto)
                                                    self.tableRefresh()
                                                }
                                            }
                                        }
                                    }
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

