//
//  PhotoTableViewCell.swift
//  P500X
//
//  Created by Rupa Sharma on 2/21/16.
//  Copyright © 2016 rupasharma. All rights reserved.
//

import UIKit

class PhotoTableViewCell : UITableViewCell {
    
    var photo: Photo? {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageBack: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureView() {
        if let photo = photo {
            self.titleLabel.text = photo.name
            self.username.text = photo.fullname
            self.userImage.image = photo.userImage
            self.mainImageBack.image = photo.image
            self.userImage.layer.cornerRadius = userImage.frame.size.width/2
            self.userImage.clipsToBounds = true
            self.userImage.layer.borderColor = UIColor.whiteColor().CGColor
            self.userImage.layer.borderWidth = 1.0

            let border = CALayer()
            let width = CGFloat(1.0)
            border.borderColor = UIColor.rupaGreen().CGColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
            
            border.borderWidth = width
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
        }
    }
    
}
