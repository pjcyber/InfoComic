//
//  FirebaseAuthViewModel.swift
//  InfoComics
//
//  Created by Pjcyber on 7/11/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//
import Foundation

struct Dates : Codable {
	let type : String?
	let date : String?

	enum CodingKeys: String, CodingKey {

		case type = "type"
		case date = "date"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		date = try values.decodeIfPresent(String.self, forKey: .date)
	}

}
