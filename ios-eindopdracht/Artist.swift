//
//  Artist.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/12/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import Foundation
import UIKit

class Artist{
    
    var id: String
    var name: String
    var photo: String?
    
    init(id: String, name: String, imageUrl: String?){
        self.id = id
        self.name = name
        self.photo = imageUrl
    }
}
