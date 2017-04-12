//
//  Album.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/12/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import Foundation

class Album{
    
    var id: String
    var name: String
    var photoSmall: String?
    var photoLarge: String?
    
    init(id: String, name: String, imageUrlSmall: String?, imageUrlLarge: String?){
        self.id = id
        self.name = name
        self.photoSmall = imageUrlSmall
        self.photoLarge = imageUrlLarge
    }
    
}
