//
//  AlbumDetailController.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/12/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumSongsTableView: UITableView!
    @IBOutlet weak var navigationFavoriteButton: UIBarButtonItem!
    @IBOutlet weak var albumFavoriteButton: UIButton!
    
    @IBAction func navigateCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func albumAddToFavoritesButton(_ sender: UIButton) {
        self.addAlbumToFavorites()
    }
    
    @IBAction func navigateFavoriteButton(_ sender: UIBarButtonItem) {
        self.addAlbumToFavorites()
    }
    
    var AlbumModel: Album? = nil
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumSongsTableView.dataSource = self
        self.setData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            if self.albumInLocalStorage() {
                self.toggleFavoriteButtons(false)
            }
            else{
                self.toggleFavoriteButtons(true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleFavoriteButtons(_ enabled: Bool){
        if enabled {
            albumFavoriteButton.isEnabled = true
            albumFavoriteButton.backgroundColor = UIColor.yellow
            albumFavoriteButton.setTitle("Add to Favorites", for: .normal)
            navigationFavoriteButton.isEnabled = true
        }else{
            albumFavoriteButton.isEnabled = false
            albumFavoriteButton.backgroundColor = UIColor.lightGray
            albumFavoriteButton.setTitle("Added!", for: .disabled)
            navigationFavoriteButton.isEnabled = false
        }
    }
    
    func addAlbumToFavorites(){
        if let album = self.AlbumModel {
            if LocalStorageRepository.Add(album){
                toggleFavoriteButtons(false)
            }
        }
    }
    
    func albumInLocalStorage() -> Bool
    {
        if let album = self.AlbumModel {
            return LocalStorageRepository.Contains(album)
        }
        return false
    }
    
    func setData(){
        if let album = self.AlbumModel {
            navigationItem.title = album.name
            if let url = album.photoLarge {
                self.albumImageView.downloadedFrom(link: url)
            }
            SpotifyAPI.GetDataFor(requestType: .Track, type: .Track, query: album.id){
                response in
                
                let resp = response as! [String:Any]
                let tracks = resp["items"] as! [[String:Any]]
                
                self.tracks.removeAll()
                for (track) in tracks {
                    let rawValues = (
                        number: track["track_number"] as! Int,
                        name: track["name"] as! String,
                        duration: track["duration_ms"] as! Int
                    )
                    
                    self.tracks.append(Track(number: rawValues.number, name: rawValues.name, duration: rawValues.duration))
                }
                DispatchQueue.main.async {
                    self.albumSongsTableView.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumDetailCell", for: indexPath) as? AlbumDetailCell else {
            fatalError("Cell not of type AlbumDetailCell")
        }
        
        let track = self.tracks[indexPath.row]
        
        cell.TrackModel = track
        cell.trackNrLabel.text = "#\(track.number)"
        cell.trackNameLabel.text = track.name
        let (m, s) = self.msToMinutesSeconds(ms: track.duration)
        cell.trackDurationLabel.text = "Duration: \(formatForUse(nr: m)):\(formatForUse(nr: s)) minutes"
        
        return cell
    }
    
    func msToMinutesSeconds (ms : Int) -> (Double, Double) {
        let seconds = Double(ms / 1000)
        let remainder = seconds.truncatingRemainder(dividingBy: 3600)
        return (remainder / 60, remainder.truncatingRemainder(dividingBy: 60))
    }
    
    func formatForUse(nr: Double) -> String {
        let rounded = String(format: "%.0f", floor(nr))
        return floor(nr) < 10 ? "0\(rounded)" : "\(rounded)"
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
