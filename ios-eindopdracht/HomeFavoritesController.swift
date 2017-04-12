//
//  ViewController.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/10/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import UIKit
import os.log

class HomeFavoritesController: UITableViewController{

    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        // Do any additional setup after loading the view, typically from a nib
        if let saved = loadData() {
            songs += saved
        }
        else{
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            songs.remove(at: indexPath.row)
            saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeFavoritesCell", for: indexPath) as? HomeFavoritesCell else {
            fatalError("Not of type HomeFavorites")
        }
        
        let song = songs[indexPath.row]
        
        cell.SongNameLabel.text = song.title
        cell.SongImage.image = song.image
        
        return cell
    }
    
    private func loadData() -> [Song]?  {
        let data = [
            Song(title: "Test song 1", image: nil)!,
            Song(title: "Test song 2", image: nil)!
        ]
        if let stored = NSKeyedUnarchiver.unarchiveObject(withFile: Song.ArchiveURL.path) as? [Song], !stored.isEmpty {
            return stored
        }
        return data
    }
    
    private func saveData(){
        
        let success = NSKeyedArchiver.archiveRootObject(songs, toFile: Song.ArchiveURL.path)
        if success {
            os_log("Data saved locally", log: OSLog.default, type: .debug)
        }
        else {
            os_log("Data save failed", log: OSLog.default, type: .error)
        }
        
    }
}

