//
//  SongSearchArtistCell.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/12/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import UIKit

class SongSearchArtistCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
