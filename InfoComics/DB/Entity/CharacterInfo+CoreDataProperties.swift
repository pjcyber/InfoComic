//
//  CharacterInfo+CoreDataProperties.swift
//  InfoComics
//
//  Created by Pjcyber on 8/9/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//
//

import Foundation
import CoreData


extension CharacterInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterInfo> {
        return NSFetchRequest<CharacterInfo>(entityName: "CharacterInfo")
    }

    @NSManaged public var descript: String?
    @NSManaged public var name: String?
    @NSManaged public var covers: NSSet?
    @NSManaged public var images: NSSet?

}

// MARK: Generated accessors for covers
extension CharacterInfo {

    @objc(addCoversObject:)
    @NSManaged public func addToCovers(_ value: Cover)

    @objc(removeCoversObject:)
    @NSManaged public func removeFromCovers(_ value: Cover)

    @objc(addCovers:)
    @NSManaged public func addToCovers(_ values: NSSet)

    @objc(removeCovers:)
    @NSManaged public func removeFromCovers(_ values: NSSet)

}

// MARK: Generated accessors for images
extension CharacterInfo {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: Img)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: Img)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}
