//
//  FirebaseAuthViewModel.swift
//  InfoComics
//
//  Created by Pjcyber on 7/11/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import Foundation

struct Items : Codable {
    let resourceURI : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case resourceURI = "resourceURI"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
