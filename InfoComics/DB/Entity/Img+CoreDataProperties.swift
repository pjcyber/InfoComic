//
//  Img+CoreDataProperties.swift
//  InfoComics
//
//  Created by Pjcyber on 8/9/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//
//

import Foundation
import CoreData


extension Img {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Img> {
        return NSFetchRequest<Img>(entityName: "Img")
    }

    @NSManaged public var image: Data?
    @NSManaged public var url: String?
    @NSManaged public var character: CharacterInfo?

}
