//
//  FirebaseAuthViewModel.swift
//  InfoComics
//
//  Created by Pjcyber on 7/11/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import Foundation

struct Events : Codable {
    let available : Int?
    let collectionURI : String?
    let items : [Items]?
    let returned : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        collectionURI = try values.decodeIfPresent(String.self, forKey: .collectionURI)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
    }
    
}
