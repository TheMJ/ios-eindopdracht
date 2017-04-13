//
//  Album.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/12/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import Foundation

class Album : NSObject, NSCoding{
    
    var id: String
    var name: String
    var photoSmall: String?
    var photoLarge: String?
    
    static let docDir = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveUrl = docDir.appendingPathComponent("eindopdracht")
    
    struct PropertyKey {
        static let id = "id"
        static let name = "name"
        static let photoSmall = "photoSmall"
        static let photoLarge = "photoLarge"
    }
    
    init(id: String, name: String, imageUrlSmall: String?, imageUrlLarge: String?){
        self.id = id
        self.name = name
        self.photoSmall = imageUrlSmall
        self.photoLarge = imageUrlLarge
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let id = aDecoder.decodeObject(forKey: PropertyKey.id) as! String
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as! String
        let photoSmall = aDecoder.decodeObject(forKey: PropertyKey.photoSmall) as! String
        let photoLarge = aDecoder.decodeObject(forKey: PropertyKey.photoLarge) as! String
        
        self.init(id: id, name: name, imageUrlSmall: photoSmall, imageUrlLarge: photoLarge)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: PropertyKey.id)
        aCoder.encode(self.name, forKey: PropertyKey.name)
        aCoder.encode(self.photoSmall, forKey: PropertyKey.photoSmall)
        aCoder.encode(self.photoLarge, forKey: PropertyKey.photoLarge)
    }
}
