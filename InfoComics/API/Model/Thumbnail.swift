//
//  FirebaseAuthViewModel.swift
//  InfoComics
//
//  Created by Pjcyber on 7/11/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import Foundation

struct Thumbnail : Codable {
    let path : String?
    let ext : String?
    
    enum CodingKeys: String, CodingKey {
        
        case path = "path"
        case ext = "extension"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        ext = try values.decodeIfPresent(String.self, forKey: .ext)
    }
    
}
