//
//  PhotoTableViewCell.swift
//  P500X
//
//  Created by Rupa Sharma on 2/21/16.
//  Copyright © 2016 rupasharma. All rights reserved.
//

import UIKit

class PhotoTableViewCell : UITableViewCell {
    
    var photo : NSDictionary?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageBack: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData (data: NSDictionary) {
        self.photo = data
        displayText()
        displayImages()
    }
    func displayText() {
        self.titleLabel.text = self.photo?.valueForKey("name") as? String
        self.username.text = "by " + ((self.photo?.valueForKey("user")!.valueForKey("fullname"))! as! String)
    }
    
    func displayImages() {
        imgFromUrl(((photo?.valueForKey("image_url")) as? String)!, imageView: mainImageBack)
        imgFromUrl((photo?.valueForKey("user")?.valueForKey("avatars")?.valueForKey("default")?.valueForKey("https") as? String)!, imageView: userImage)
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = 40
    }
    
    func imgFromUrl(url: String, imageView: UIImageView) {
        let imageURL : NSURL = NSURL(string: url)!
        var data: NSData? = nil
        do {
            data = try NSData(contentsOfURL: imageURL, options:NSDataReadingOptions.DataReadingMappedIfSafe)
        }
        catch {
            print("We have an image issue \(error)")
        }
        if (data != nil) {
            imageView.image = UIImage(data: data!)
        }
        
        
    }
}
