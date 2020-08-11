//
//  CharacterData.swift
//  InfoComics
//
//  Created by Pjcyber on 7/25/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import Foundation

class Character: Codable {
    
    var name: String
    var description: String
    var comics = [String]()
    var covers = [Data]()
    var image: Data?
    var imageURI: String
    
    init(name: String, imageURI: String, description: String, comics: [String]) {
        self.name = name
        self.imageURI = imageURI
        self.description = description
        self.comics = comics
    }
    
    func getName() -> String {
        return name
    }
    
    func getDescription() -> String {
        return description
    }
    
    func getComics() -> [String] {
        return comics
    }
    
    func setCovers(covers: [Data]) {
        if self.covers.count == 0 {
            self.covers.append(contentsOf: covers)
        }
    }
    
    func getCovers() -> [Data] {
        return covers
    }
    
    func setImage(image: Data) {
        self.image = image
    }
    
    func getImage() -> Data? {
        return self.image
    }
}
