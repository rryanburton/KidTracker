//
//  MomentTableViewCell.swift
//  KidTracker
//
//  Created by 3delrb on 2/8/16.
//  Copyright © 2016 Ryan Burton. All rights reserved.
//

import UIKit

class MomentTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
