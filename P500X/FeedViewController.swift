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
    var photoCollection : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getPhotos()
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detailVC = segue.destinationViewController as? DetailViewController {
            let selected : NSIndexPath = self.tableView.indexPathForSelectedRow!
            let photo : NSDictionary = photoCollection[selected.row] as! NSDictionary
            detailVC.photo = photo
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPhotos() -> () {
        let url:NSURL = NSURL(string: "https://api.500px.com/v1/photos?feature=popular&consumer_key=vW8Ns53y0F57vkbHeDfe3EsYFCatTJ3BrFlhgV3W")!;
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                if let jsonData = data {
                    do {
                        let jsonResult : NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        self.photoCollection = jsonResult.valueForKey("photos") as! NSMutableArray
                    } catch {
                        print("Json Serialization error")
                    }
                }
                self.do_table_refresh()
            }
        }
        task.resume()
    }
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photoCollection.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PhotoTableViewCell
        if indexPath.row < photoCollection.count {
            let photo : NSDictionary = photoCollection[indexPath.row] as! NSDictionary
            cell.loadData(photo)
            cell.layoutIfNeeded()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: self.photoCollection[indexPath.row])
    }

}

