//
//  DetailViewController.swift
//  P500X
//
//  Created by Rupa Sharma on 2/21/16.
//  Copyright © 2016 rupasharma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var photo : NSDictionary?
    
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var detailText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        titleLabel.text = photo?.valueForKey("name") as? String
        displayImages()
        displayText()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayText() {
        let generalTextAttributes = NSMutableParagraphStyle()
        generalTextAttributes.alignment = NSTextAlignment.Left
        generalTextAttributes.paragraphSpacing = 10.0
        var boldTextStyle = [String: NSObject]()
        boldTextStyle[NSFontAttributeName] = UIFont(name: "HelveticaNeue-Medium", size: 24.0)
        boldTextStyle[NSParagraphStyleAttributeName] = generalTextAttributes
        
        var plainTextStyle = [String: NSObject]()
        plainTextStyle[NSFontAttributeName] = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        plainTextStyle[NSParagraphStyleAttributeName] = generalTextAttributes
        
        let attributedText : NSMutableAttributedString = NSMutableAttributedString(string: "by ", attributes: plainTextStyle)
        attributedText.appendAttributedString(NSMutableAttributedString(string: (photo?.valueForKey("user")?.valueForKey("fullname") as! String), attributes: boldTextStyle))
        attributedText.appendAttributedString(NSMutableAttributedString(string: "\n", attributes: plainTextStyle))
        attributedText.appendAttributedString(NSMutableAttributedString(string: photo?.valueForKey("description") as! String, attributes: plainTextStyle))
        attributedText.appendAttributedString(NSMutableAttributedString(string: "\n", attributes: plainTextStyle))
        
        detailText.attributedText = attributedText
        
        detailText.sizeToFit()
        
    }
    
    func displayImages() {
        imgFromUrl((photo?.valueForKey("image_url"))! as! String, imageView: imageView)
        imgFromUrl(photo?.valueForKey("user")! .valueForKey("avatars")!.valueForKey("default")!.valueForKey("https")! as! String, imageView: userImageView)
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = 50
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
