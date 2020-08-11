//
//  FirebaseAuthViewModel.swift
//  InfoComics
//
//  Created by Pjcyber on 7/11/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//
import Foundation

struct ComicResults : Codable {
	let id : Int?
	let digitalId : Int?
	let title : String?
	let issueNumber : Int?
	let variantDescription : String?
	let description : String?
	let modified : String?
	let isbn : String?
	let upc : String?
	let diamondCode : String?
	let ean : String?
	let issn : String?
	let format : String?
	let pageCount : Int?
	let textObjects : [String]?
	let resourceURI : String?
	let urls : [Urls]?
	let series : ComicSeries?
	let variants : [String]?
	let collections : [String]?
	let collectedIssues : [String]?
	let dates : [Dates]?
	let prices : [Prices]?
	let thumbnail : Thumbnail?
	let images : [String]?
	let creators : Creators?
	let characters : Characters?
	let stories : Stories?
	let events : Events?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case digitalId = "digitalId"
		case title = "title"
		case issueNumber = "issueNumber"
		case variantDescription = "variantDescription"
		case description = "description"
		case modified = "modified"
		case isbn = "isbn"
		case upc = "upc"
		case diamondCode = "diamondCode"
		case ean = "ean"
		case issn = "issn"
		case format = "format"
		case pageCount = "pageCount"
		case textObjects = "textObjects"
		case resourceURI = "resourceURI"
		case urls = "urls"
		case series = "series"
		case variants = "variants"
		case collections = "collections"
		case collectedIssues = "collectedIssues"
		case dates = "dates"
		case prices = "prices"
		case thumbnail = "thumbnail"
		case images = "images"
		case creators = "creators"
		case characters = "characters"
		case stories = "stories"
		case events = "events"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		digitalId = try values.decodeIfPresent(Int.self, forKey: .digitalId)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		issueNumber = try values.decodeIfPresent(Int.self, forKey: .issueNumber)
		variantDescription = try values.decodeIfPresent(String.self, forKey: .variantDescription)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		modified = try values.decodeIfPresent(String.self, forKey: .modified)
		isbn = try values.decodeIfPresent(String.self, forKey: .isbn)
		upc = try values.decodeIfPresent(String.self, forKey: .upc)
		diamondCode = try values.decodeIfPresent(String.self, forKey: .diamondCode)
		ean = try values.decodeIfPresent(String.self, forKey: .ean)
		issn = try values.decodeIfPresent(String.self, forKey: .issn)
		format = try values.decodeIfPresent(String.self, forKey: .format)
		pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount)
		textObjects = try values.decodeIfPresent([String].self, forKey: .textObjects)
		resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
		urls = try values.decodeIfPresent([Urls].self, forKey: .urls)
		series = try values.decodeIfPresent(ComicSeries.self, forKey: .series)
		variants = try values.decodeIfPresent([String].self, forKey: .variants)
		collections = try values.decodeIfPresent([String].self, forKey: .collections)
		collectedIssues = try values.decodeIfPresent([String].self, forKey: .collectedIssues)
		dates = try values.decodeIfPresent([Dates].self, forKey: .dates)
		prices = try values.decodeIfPresent([Prices].self, forKey: .prices)
		thumbnail = try values.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
		images = try values.decodeIfPresent([String].self, forKey: .images)
		creators = try values.decodeIfPresent(Creators.self, forKey: .creators)
		characters = try values.decodeIfPresent(Characters.self, forKey: .characters)
		stories = try values.decodeIfPresent(Stories.self, forKey: .stories)
		events = try values.decodeIfPresent(Events.self, forKey: .events)
	}

}
