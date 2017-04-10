//
//  Song.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/10/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Song : NSObject, NSCoding{
    
    var image: UIImage?
    var title: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    struct PropertyKey {
        static let title = "title"
        static let image = "image"
    }
    
    init?(title: String, image: UIImage?){
        guard !title.isEmpty else {
            return nil
        }
        
        self.image = image
        self.title = title
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else{
            os_log("Unable to decode title", log: OSLog.default, type: .debug)
            return nil
        }
        
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        
        self.init(title: title, image: image)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(image, forKey: PropertyKey.image)
    }
}
