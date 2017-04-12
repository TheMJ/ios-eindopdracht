//
//  ArtistDetailController.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/12/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import Foundation
import UIKit

class ArtistDetailController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var artistPhoto: UIImageView!
    @IBOutlet weak var artistAlbumTableView: UITableView!
    
    var ArtistModel: Artist? = nil
    var albums = [Album]()
    
    @IBAction func DoneButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistAlbumTableView.dataSource = self
        self.setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setData()
    {
        if let artist = self.ArtistModel {
            navigationItem.title = artist.name
            if let url = artist.photoLarge {
                self.artistPhoto.downloadedFrom(link: url)
            }
            SpotifyAPI.GetDataFor(requestType: .Album, type: .Album, query: artist.id){
                response in
                
                let resp = response as! [String:Any]
                
                let albums = resp["items"] as! [[String:Any]]
                
                self.albums.removeAll()
                for (entry) in albums {
                    let images = entry["images"] as! [[String:Any]]
                    
                    let rawValue = (
                        id: entry["id"] as! String,
                        name: entry["name"] as! String,
                        photoSmall: images.last?["url"] as! String,
                        photoLarge: images.first?["url"] as! String
                    )
                    
                    self.albums.append(Album(id: rawValue.id, name: rawValue.name, imageUrlSmall: rawValue.photoSmall, imageUrlLarge: rawValue.photoLarge))
                }
                DispatchQueue.main.async(){
                    self.artistAlbumTableView.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistDetailCell", for: indexPath) as? ArtistDetailCell else {
            fatalError("Cell not of type ArtistDetailCell")
        }
        
        let album = albums[indexPath.row]
        
        cell.AlbumModel = album
        cell.albumName.text = album.name
        if let url = album.photoSmall {
            cell.albumImage.downloadedFrom(link: url)
        }
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nvc = segue.destination as? UINavigationController {
            if let vc = nvc.visibleViewController as? AlbumDetailController {
                if let cell = sender as? ArtistDetailCell {
                    if let album = cell.AlbumModel {
                        vc.AlbumModel = album
                    }
                }
            }
        }
    }
}
