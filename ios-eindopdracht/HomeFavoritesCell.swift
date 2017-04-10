//
//  HomeFavorites.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/10/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import UIKit

class HomeFavoritesCell: UITableViewCell {

    //MARK - properties
    @IBOutlet weak var SongImage: UIImageView!
    @IBOutlet weak var SongNameLabel: UILabel!
    @IBOutlet weak var SongBuyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
