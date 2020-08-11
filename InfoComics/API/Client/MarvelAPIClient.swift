//
//  MarvelAPI.swift
//  InfoComics
//
//  Created by Pjcyber on 7/20/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import Foundation
import Alamofire
//import AlamofireImage


class MarvelAPIClient {
    
    // Endpoints model
    enum Endpoints {
        static let base = "https://gateway.marvel.com/v1/public"
        static let ts = "1"
        static let apikey = "e9669fc4ab231a1144427c1b2e2601ee"
        static let hash = "bf2149f5c0f61fa3f7c7735f7221020b"
        
        case characters(name: String)
        case comics(collectionURI: String)
        
        var stringValue: String {
            switch self {
            case .characters(let name):
                return Endpoints.base + "/characters?" + "ts=\(Endpoints.ts)&apikey=\(Endpoints.apikey)&hash=\(Endpoints.hash)&name=\(name)"
            case .comics(let collectionURI):
                return collectionURI + "?ts=\(Endpoints.ts)&apikey=\(Endpoints.apikey)&hash=\(Endpoints.hash)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getCharacterDetails(character: String, completion: @escaping (Character?, Error?) -> Void) {
        let request = AF.request(Endpoints.characters(name: character.replacingOccurrences(of: " ", with: "+")).stringValue)
        request.responseDecodable(of: CharacterInfoResponse.self) { response in
            switch response.result {
            case .success( _):
                guard let character = response.value, let characterData = character.data?.results else {
                    return
                }
                if (characterData.count > 0) {
                    guard
                        let name = characterData[0].name,
                        let imagePath = characterData[0].thumbnail?.path,
                        let imageExt = characterData[0].thumbnail?.ext,
                        let description = characterData[0].description,
                        let comics = characterData[0].comics?.collectionURI else  { return }
                    
                    let imageUrl = imagePath + "." + imageExt
                    
                    getComicUrl(comicsCollection: comics, completion: { images, error in
                        guard let comicsUrls = images else {
                            return
                        }
                        let character = Character(name: name, imageURI: imageUrl, description: description, comics: comicsUrls)
                        completion(character, nil)
                    })
                } else {
                    //let character = Character(name: "", imageURI: "", description: "", comics: [])
                    completion(nil, nil)
                    print("no ay")
                }
                break
            case .failure(let error):
                completion(nil, error)
                break
            }
        }
    }
    
    class func getComicUrl(comicsCollection: String, completion: @escaping ([String]?, Error?) -> Void) {
        let collectionUri = comicsCollection.replacingOccurrences(of: "http", with: "https")
        let request = AF.request(Endpoints.comics(collectionURI: collectionUri).stringValue)
        request.responseDecodable(of: ComicsInfoResponse.self) { response in
            switch response.result {
            case .success( _):
                guard let comics = response.value, let infos = comics.data?.results else {
                    return
                }
                var imagesPaths = [String]()
                if infos.count > 0 {
                    for info in infos {
                        if let thumbnail = info.thumbnail {
                            let image = thumbnail.path! + "." + thumbnail.ext!
                            print("coco ...coak \(image)")
                            imagesPaths.append(image)
                            if imagesPaths.count == 5 {
                                completion(imagesPaths, nil)
                                return
                            }
                        }
                    }
                }
                completion(imagesPaths, nil)
                break
            case .failure(let error):
                completion(nil, error)
                break
            }
        }
    }
    
    class func getComicImage(photoUri: String, completion: @escaping (Data?, Error?) -> Void) {
        let photoUrl = photoUri.replacingOccurrences(of: "http", with: "https")
        print("coco ... image uri \(photoUrl)")
        AF.request(photoUrl, method: .get).responseData(completionHandler: { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
                break
            case .failure(let error):
                completion(nil, error)
                break
            }
        })
    }
}
