//
//  FirebaseAuthViewModel.swift
//  InfoComics
//
//  Created by Pjcyber on 7/11/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//
import Foundation

struct ComicItems : Codable {
	let resourceURI : String?
	let name : String?
	let type : String?

	enum CodingKeys: String, CodingKey {

		case resourceURI = "resourceURI"
		case name = "name"
		case type = "type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

}
