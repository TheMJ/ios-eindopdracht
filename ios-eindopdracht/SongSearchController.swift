//
//  SongSearchController.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/10/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import UIKit
import os.log

class SongSearchController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var Artists = [Artist]()
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Artists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "SongSearchArtistCell", for: indexPath) as? SongSearchArtistCell else {
            fatalError("Cell not found")
        }
        
        let artist = Artists[indexPath.row]
        
        cell.nameLabel.text = artist.name
        if let url = artist.photo {
            cell.photoImageView.downloadedFrom(link: url)
        }        
        
        return cell
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        os_log("Begin editing")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        os_log("Search Button")
        SpotifyAPI.SearchFor(type: .Artist, query: searchBar.text!) {
            response in
            
            var resp = response as! [String:Any]
            
            let artists = resp["artists"] as! [String:Any]
            let items = artists["items"] as! [[String:Any]]
            
            
            self.Artists.removeAll()
            for (artist) in items{
                let id = artist["id"] as! String
                let name = artist["name"] as! String
                let images = artist["images"] as! [[String:Any]]
                
                var imageUrl = ""
                if images.count > 0 {
                    imageUrl = images.last?["url"] as! String
                }
                self.Artists.append(Artist(id: id, name: name, imageUrl: imageUrl))
            }
            DispatchQueue.main.async(){
                self.tableView.reloadData()
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
