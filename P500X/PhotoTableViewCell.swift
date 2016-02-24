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
        }
    }
    
}
