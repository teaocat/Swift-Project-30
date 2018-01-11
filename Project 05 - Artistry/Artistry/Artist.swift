//
//  Artist.swift
//  Artistry
//
//  Created by Teaocat on 2018/1/11.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

struct Artist {
    let image: UIImage
    let name: String
    let bio: String
    var works: [Work]
    
    init(name: String, bio: String, image: UIImage, works: [Work]) {
        self.name = name
        self.bio = bio
        self.image = image
        self.works = works
    }
    
    static func artistsFromBundle() -> [Artist] {
        var artists = [Artist]()
        
        guard let url = Bundle.main.url(forResource: "artists", withExtension: "json") else {
            return artists
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            guard let rootObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return artists
            }
            
            guard let artistsObject = rootObject["artists"] as? [[String: Any]] else {
                return artists
            }
            
            for artistObject in artistsObject {
                if let name = artistObject["name"] as? String,
                    let bio = artistObject["bio"] as? String,
                    let imageNamed = artistObject["image"] as? String,
                    let image = UIImage(named: imageNamed),
                    let worksObject = artistObject["works"] as? [[String: String]] {
                    var works = [Work]()
                    for workObject in worksObject {
                        if let title = workObject["title"],
                            let imageNamed = workObject["image"],
                            let image = UIImage(named: imageNamed + ".jpg"),
                            let info = workObject["info"] {
                            let work = Work(title: title, image: image, info: info, isExpanded: false)
                            works.append(work)
                        }
                    }
                    
                    let artist = Artist(name: name, bio: bio, image: image, works: works)
                    artists.append(artist)
                }
            }
        } catch {
            return artists
        }
        
        return artists
    }
    
}
