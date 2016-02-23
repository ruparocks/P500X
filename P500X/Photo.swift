//
//  Photo.swift
//  P500X
//
//  Created by Rupa Sharma on 2/23/16.
//  Copyright © 2016 rupasharma. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    var name : String
    var fullname : String
    var description : String
    var image : UIImage = UIImage(named: "placeholder")!
    var userImage : UIImage = UIImage(named: "placeholder")!
    
    init(name: String, fullname: String, description: String, imageUrl: String, userImageUrl: String) {
        self.name = name
        self.fullname = fullname
        self.description = description
        self.image = imageFromUrl(imageUrl)
        self.userImage = imageFromUrl(userImageUrl)
    }
    
    func imageFromUrl(url: String) -> UIImage {
        let imageURL : NSURL = NSURL(string: url)!
        var data: NSData? = nil
        do {
            data = try NSData(contentsOfURL: imageURL, options:NSDataReadingOptions.DataReadingMappedIfSafe)
        }
        catch {
            print("We have an image issue \(error)")
        }
        if (data != nil) {
            return UIImage(data: data!)!
        }
        return UIImage(named: "error")!
    }
}
