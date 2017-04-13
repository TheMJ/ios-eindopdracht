//
//  SpotifyAPI.swift
//  ios-eindopdracht
//
//  Created by Mike Jaartsveld on 4/11/17.
//  Copyright © 2017 Mike Jaartsveld. All rights reserved.
//

import Foundation

class SpotifyAPI{
    
    static let baseRequestUrl = "https://api.spotify.com/v1/"
    
    enum ContentType{
        case Artist
        case Album
        case Track
    }
    
    enum ActionType{
        case Search
        case Album
        case Track
    }
    
    static func SearchFor(type: ContentType, query: String, complete: @escaping (_ response: Any) -> Void){
        if let cleanedQuery = self.CleanString(query) {
            let requestUrl = self.BuildRequestUrl(requestType: .Search, contentType: type, cleanedQuery)
            self.ExecuteRequest(requestUrl, complete)
        }
    }
    
    static func GetDataFor(requestType: ActionType, type: ContentType, query: String, complete: @escaping (_ response: Any) -> Void){
        if let cleanedQuery = self.CleanString(query) {
            let reqUrl = self.BuildRequestUrl(requestType: requestType, contentType: type, cleanedQuery)
            self.ExecuteRequest(reqUrl, complete)
        }
    }
    
    static func ExecuteRequest(_ url: String, _ complete: @escaping (_ response: Any) -> Void){
        let urlObj = URL(string: url)
        
        let task = URLSession.shared.dataTask(with: urlObj!) {
            data, response, error in
            
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            complete(json)
        }
        
        task.resume()
    }
    
    static func BuildRequestUrl(requestType: ActionType, contentType: ContentType, _ query: String) -> String{
        var requestUrl = ""
        
        switch requestType
        {
            case .Search:
                requestUrl += "search?q=" + query
            case .Album:
                requestUrl += "artists/" + query
            case .Track:
                requestUrl += "albums/" + query
        }
        
        switch contentType {
            case .Artist:
                requestUrl += "&type=artist&limit=50"
            case .Album:
                requestUrl += "/albums?market=NL&limit=50"
            case .Track:
                requestUrl += "/tracks?limit=50"
        }
        
        return self.baseRequestUrl + requestUrl
    }
    
    static func CleanString(_ query: String) -> String?{
        var newQuery = query
        
        newQuery = newQuery.trimmingCharacters(in: .whitespaces)
        
        if let result = newQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            newQuery = result
        }
        
        if( newQuery.isEmpty )
        {
            return nil
        }
        return newQuery;
    }
}
