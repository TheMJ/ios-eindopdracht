//
//  Track.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/12/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import Foundation

class Track {
    
    var number: Int
    var name: String
    var duration: Int
    
    init(number: Int, name: String, duration: Int){
        self.number = number
        self.name = name
        self.duration = duration
    }
}
