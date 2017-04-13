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

    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        // Do any additional setup after loading the view, typically from a nib
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
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
            albums.remove(at: indexPath.row)
            saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeFavoritesCell", for: indexPath) as? HomeFavoritesCell else {
            fatalError("Not of type HomeFavorites")
        }
        
        let album = albums[indexPath.row]
        cell.AlbumModel = album
        cell.SongNameLabel.text = album.name
        if let url = album.photoSmall {
            cell.SongImage.downloadedFrom(link: url)
        }
        return cell
    }
    
    private func loadData() {
        if let stored = LocalStorageRepository.LoadData() {
            albums = stored
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        else{
            print("First run, saving empty object")
            self.saveData()
        }
    }
    
    private func saveData(){
        LocalStorageRepository.SaveData(self.albums)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nvc = segue.destination as? UINavigationController {
            if let vc = nvc.visibleViewController as? AlbumDetailController {
                if let cell = sender as? HomeFavoritesCell {
                    if let album = cell.AlbumModel {
                        vc.AlbumModel = album
                    }
                }
            }
        }
    }
}

