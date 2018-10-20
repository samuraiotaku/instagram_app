//
//  HomeFeedCell.swift
//  instagram
//
//  Created by Brandon Shimizu on 10/4/18.
//  Copyright © 2018 Brandon Shimizu. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class HomeFeedCell: UITableViewCell {

    @IBOutlet weak var postImage: PFImageView!
    
    @IBOutlet weak var postCaption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var instagramPost: PFObject! {
        didSet {
            self.postImage.file = instagramPost["image"] as? PFFile
            self.postImage.loadInBackground()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
