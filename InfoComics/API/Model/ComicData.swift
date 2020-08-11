//
//  ComicData.swift
//  InfoComics
//
//  Created by Pjcyber on 7/26/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import Foundation

struct ComicData : Codable {
    let offset : Int?
    let limit : Int?
    let total : Int?
    let count : Int?
    let results : [Results]?

    enum CodingKeys: String, CodingKey {

        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
    }

}
