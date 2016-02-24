//
//  DetailViewController.swift
//  P500X
//
//  Created by Rupa Sharma on 2/21/16.
//  Copyright © 2016 rupasharma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoText: UITextView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var image: UIImageView!

    var detailPhoto: Photo? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        infoText.scrollRangeToVisible(NSRange(location: 0,length: 0))
    }
    
    func configureView() {
        if let detailPhoto = detailPhoto {
            if let titleLabel = titleLabel, infoText = infoText, userImage = userImage, image = image {
                titleLabel.text = detailPhoto.name
                infoText.attributedText = descriptionText(detailPhoto.fullname, description: detailPhoto.description)
                infoText.scrollRangeToVisible(NSRange(location: 0,length: 0))
                image.image = detailPhoto.image
                userImage.image = detailPhoto.userImage
                userImage.layer.cornerRadius = userImage.frame.size.width/2
                userImage.clipsToBounds = true
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func descriptionText(fullname: String, description: String) -> NSAttributedString {
        let generalTextAttributes = NSMutableParagraphStyle()
        generalTextAttributes.alignment = NSTextAlignment.Left
        generalTextAttributes.paragraphSpacing = 10.0
        
        var plainTextStyle = [String: NSObject]()
        plainTextStyle[NSFontAttributeName] = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        plainTextStyle[NSParagraphStyleAttributeName] = generalTextAttributes
        
        var boldTextStyle = [String: NSObject]()
        boldTextStyle[NSFontAttributeName] = UIFont(name: "HelveticaNeue-Medium", size: 24.0)
        boldTextStyle[NSForegroundColorAttributeName] = UIColor.rupaGreen()
        boldTextStyle[NSParagraphStyleAttributeName] = generalTextAttributes
        
        let attributedText : NSMutableAttributedString = NSMutableAttributedString(string: "by ", attributes: plainTextStyle)
        attributedText.appendAttributedString(NSMutableAttributedString(string: fullname, attributes: boldTextStyle))
        attributedText.appendAttributedString(NSMutableAttributedString(string: "\n" + description + "\n", attributes: plainTextStyle))
        
        return attributedText
    }
}