//
//  FirebaseAuthViewModel.swift
//  InfoComics
//
//  Created by Pjcyber on 7/11/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//
import Foundation

struct Prices : Codable {
	let type : String?
	let price : Int?

	enum CodingKeys: String, CodingKey {

		case type = "type"
		case price = "price"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		price = try values.decodeIfPresent(Int.self, forKey: .price)
	}

}
