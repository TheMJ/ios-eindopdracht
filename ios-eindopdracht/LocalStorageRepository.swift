//
//  LocalStorageRepository.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/13/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import Foundation

class LocalStorageRepository{
    
    static func LoadData() -> [Album]?{
        if let stored = NSKeyedUnarchiver.unarchiveObject(withFile: Album.ArchiveUrl.path) as? [Album] {
            return stored
        }
        return nil
    }
    
    static func SaveData(_ data: [Album]) -> Bool{
        return NSKeyedArchiver.archiveRootObject(data, toFile: Album.ArchiveUrl.path)
    }
    
    static func Add(_ item: Album) -> Bool {
        if var stored = LoadData(){
            if !Contains(item) {
                stored.append(item)
                return SaveData(stored)
            }
        }
        return false
    }
    
    static func Contains(_ item: Album) -> Bool{
        if let stored = LoadData() {
            let result = stored.contains {
                element in
                
                if item.id == element.id {
                    return true
                }
                return false
            }
            return result
        }
        else{
            fatalError("LocalStorage not loaded")
        }
    }
    
}
