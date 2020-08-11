//
//  CollectionViewModel.swift
//  InfoComics
//
//  Created by Pjcyber on 8/6/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import Foundation
import Combine
import CoreData

class CollectionViewModel {
    
    internal var charactersResult: [Character] = []
    
    class func getCharacter()  -> AnyPublisher<[Character], Error> {
        var charactersResult: [Character] = []
        let future = Future<[Character], Error> { promise in
            let fetchRequest: NSFetchRequest<CharacterInfo> = CharacterInfo.fetchRequest()
            do {
                let characters = try DataController.context.fetch(fetchRequest)
                for character in characters {
                    let fetchRequest: NSFetchRequest<Cover> = Cover.fetchRequest()
                    let predicate = NSPredicate(format: "character == %@", character)
                    fetchRequest.predicate = predicate
                    do {
                        let covers = try DataController.context.fetch(fetchRequest)
                        let characterData = Character(name: character.name!, imageURI: "", description: character.descript!, comics: covers.map({ cover -> String in cover.url! }))
                        characterData.setCovers(covers: covers.map({ cover -> Data in cover.image!}))
                        
                        let fetchImgRequest: NSFetchRequest<Img> = Img.fetchRequest()
                        fetchImgRequest.predicate = predicate
                        
                        let img = try DataController.context.fetch(fetchImgRequest)
                        if img.count > 0 {
                            characterData.setImage(image: img[0].image!)
                        }
                        charactersResult.append(characterData)
                    } catch {
                        let error = error as NSError
                        promise(.failure(error))
                    }
                }
                promise(.success(charactersResult))
            } catch {
                let error = error as NSError
                promise(.failure(error))
            }
        }
        return AnyPublisher(future).eraseToAnyPublisher()
    }
}
