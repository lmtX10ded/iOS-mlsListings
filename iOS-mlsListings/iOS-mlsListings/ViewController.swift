//
//  ViewController.swift
//  iOS-mlsListings
//
//  Created by My Computer on 2018-11-12.
//  Copyright © 2018 Kish. All rights reserved.
//

import UIKit

struct Feed: Codable {
    let title: String
    let id: URL
    let copyright: String
    let country: String
    let icon: URL
    let updated: Date
    let results: [FeedItem]
}

struct FeedItem: Codable{
    let artistUrl: URL
    let artistId: String
    let artistName: String
    let artworkUrl100: URL
    let copyright: String
    let id: String
    let name: String
    let releaseDate: Date
    let url: URL
}

class ViewController: UIViewController {
    
    //Decodes the 'updated' fields in 'Feed' structs.
    lazy var dateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    //Decodes the 'releaseDate' fields in 'FeedItem' structs
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    //Decodes a Feed with embedded 'FeedItem's and multiple date formats.
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom {
            decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            if let date = self.dateTimeFormatter.date(from: dateString){
                return date
            }
            
            if let date = self.dateFormatter.date(from: dateString){
                return date
            }
            
            return Date()
        }
        return decoder
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/non-explicit.json")
        
        let task = URLSession.shared.dataTask(with: url!) {
            
            (data, response, error) in
            guard let data = data else {
                print("Error: \(String(describing: error))")
                return
            }
            
            if let appsList = String.init(data: data, encoding: String.Encoding.utf8) {
                print(appsList)
            }
            
        }
        
        task.resume()
        
    }


}

