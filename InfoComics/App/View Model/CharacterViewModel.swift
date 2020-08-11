//
//  CharacterViewModel.swift
//  InfoComics
//
//  Created by Pjcyber on 7/26/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import Foundation
import Combine
import CoreData

class CharacterViewModel {
    
    class func getCharacter(character: String) -> AnyPublisher<Character?, Error> {
        let future = Future<Character?, Error> { promise in
            MarvelAPIClient.getCharacterDetails(character: character, completion: {characterData, error in
                if let error = error {
                    promise(.failure(error))
                }
                promise(.success(characterData))
            })
        }
        return AnyPublisher(future).eraseToAnyPublisher()
    }
    
    
    class func getCharacterImage(imageURI: String) -> AnyPublisher<Data, Error> {
        let future = Future<Data, Error> { promise in
            MarvelAPIClient.getComicImage(photoUri: imageURI) { data, error in
                if let error = error {
                    promise(.failure(error))
                }
                if let data = data {
                    promise(.success(data))
                }
            }
        }
        return AnyPublisher(future).eraseToAnyPublisher()
    }
    
    class func getComicCovers(comicsCovers: [String]) -> AnyPublisher<[Data], Error> {
        let future = Future<[Data], Error> { promise in
            var coversData = [Data]()
            for cover in comicsCovers {
                MarvelAPIClient.getComicImage(photoUri: cover) { data, error in
                    if let error = error {
                        promise(.failure(error))
                    }
                    if let data = data {
                        coversData.append(data)
                        if coversData.count > 4 {
                            promise(.success(coversData))
                        }
                    }
                }
            }
            
        }
        return AnyPublisher(future).eraseToAnyPublisher()
    }
    
    
    class func saveData(name: String, description: String, uris: [String], characterImage: Data, covers: [Data]) {
        
        let character = CharacterInfo(context: DataController.context)
        character.name = name
        character.descript = description
        let img = Img(context: DataController.context)
        img.image = characterImage
        img.url = uris[0]
        character.addToImages(img)
        
        var i = 0
        for data in covers {
            let cover = Cover(context: DataController.context)
            cover.image =  data
            cover.url = uris[i]
            character.addToCovers(cover)
            i += 1
        }
        DataController.saveContext()
    }
    
    class func deleteData(name: String) {
        let fetchRequest: NSFetchRequest<CharacterInfo> = CharacterInfo.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        do {
            let characters = try DataController.context.fetch(fetchRequest)
            if characters.count > 0 {
                for character in characters {
                    DataController.context.delete(character)
                    DataController.saveContext()
                }
            }
        } catch {
            
        }
    }
    
    class func exists(name: String) -> Bool {
        let fetchRequest: NSFetchRequest<CharacterInfo> = CharacterInfo.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        do {
            let characters = try DataController.context.fetch(fetchRequest)
            if characters.count > 0 {
                return true
            }
        } catch {
            return false
        }
        
        return false
    }
}
