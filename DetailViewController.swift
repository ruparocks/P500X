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
    
    func configureView() {
        if let detailPhoto = detailPhoto {
            if let titleLabel = titleLabel, infoText = infoText, userImage = userImage, image = image {
                titleLabel.text = detailPhoto.name
                infoText.attributedText = descriptionText(detailPhoto.fullname, description: detailPhoto.description)
                image.image = detailPhoto.image
                userImage.image = detailPhoto.userImage
                
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
        var boldTextStyle = [String: NSObject]()
        boldTextStyle[NSFontAttributeName] = UIFont(name: "HelveticaNeue-Medium", size: 24.0)
        boldTextStyle[NSParagraphStyleAttributeName] = generalTextAttributes
        
        var plainTextStyle = [String: NSObject]()
        plainTextStyle[NSFontAttributeName] = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        plainTextStyle[NSParagraphStyleAttributeName] = generalTextAttributes
        
        let attributedText : NSMutableAttributedString = NSMutableAttributedString(string: "by ", attributes: plainTextStyle)
        attributedText.appendAttributedString(NSMutableAttributedString(string: fullname, attributes: boldTextStyle))
        attributedText.appendAttributedString(NSMutableAttributedString(string: "\n", attributes: plainTextStyle))
        attributedText.appendAttributedString(NSMutableAttributedString(string: description, attributes: plainTextStyle))
        attributedText.appendAttributedString(NSMutableAttributedString(string: "\n", attributes: plainTextStyle))
        
        return attributedText
    }
}