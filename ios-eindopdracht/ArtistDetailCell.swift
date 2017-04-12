//
//  ArtistDetailCell.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/12/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import UIKit

class ArtistDetailCell : UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    
    var AlbumModel: Album? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
