//
//  Cover+CoreDataProperties.swift
//  InfoComics
//
//  Created by Pjcyber on 8/9/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//
//

import Foundation
import CoreData


extension Cover {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cover> {
        return NSFetchRequest<Cover>(entityName: "Cover")
    }

    @NSManaged public var image: Data?
    @NSManaged public var url: String?
    @NSManaged public var character: CharacterInfo?

}
