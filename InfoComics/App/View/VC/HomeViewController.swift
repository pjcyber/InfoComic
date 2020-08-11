//
//  HomeViewController.swift
//  InfoComics
//
//  Created by Pjcyber on 7/12/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import UIKit
import iCarousel
import Combine

class HomeViewController: BaseViewController, UISearchBarDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterDescription: UITextView!
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var carouselContainer: UIView!
    
    // MARK: - Constants
    let margin: CGFloat = 20
    let origin: CGFloat = 10
    let comicCarousel: iCarousel = {
        let view = iCarousel()
        view.type = .coverFlow
        return view
    }()
    
    // MARK: - Variables
    internal var dataArray: [Data] = []
    internal var imageUriArray: [String] = []
    internal var charaterSaved: Bool = false
    internal var searchingMode: Bool = false
    
    // MARK: Suscribers
    private var characterInfoSubscriber: AnyCancellable?
    private var characterImageSubscriber: AnyCancellable?
    private var comicCoversSubscriber: AnyCancellable?
    
    // MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        carouselContainer.addSubview(comicCarousel)
        comicCarousel.dataSource = self
        comicCarousel.frame = CGRect(x: origin, y: origin, width: self.carouselContainer.frame.width-margin, height: self.carouselContainer.frame.height-margin)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
    
    // MARK: - Actions
    @IBAction func saveCharacter(_ sender: UIButton) {
        if charaterSaved {
            saveButton.setImage(UIImage(named: "unfavorite"), for: .normal)
            CharacterViewModel.deleteData(name: characterName.text!)
            charaterSaved = false
            
        } else {
            charaterSaved = true
            saveButton.setImage(UIImage(named: "favorite"), for: .normal)
            CharacterViewModel.saveData(name: characterName.text!, description: characterDescription.text, uris: imageUriArray, characterImage: characterImage.image!.pngData()!, covers: dataArray)
        }
    }
    
    func setCharacterImage(imageURL: String) {
        characterImageSubscriber = CharacterViewModel.getCharacterImage(imageURI: imageURL)
            .sink(receiveCompletion: {error in }, receiveValue: {data in
                self.characterImage.image = UIImage(data: data)
            })
    }
    
    func setComicCovers(comicsUris: [String]) {
        comicCoversSubscriber = CharacterViewModel.getComicCovers(comicsCovers: comicsUris)
            .sink(receiveCompletion: { (error) in }, receiveValue: { covers in
                self.dataArray.append(contentsOf: covers)
                self.comicCarousel.reloadData()
            })
    }
    
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingMode = true
        characterInfoSubscriber = CharacterViewModel.getCharacter(character: searchText)
            .sink(receiveCompletion: {error in }, receiveValue: { characterData in
                if let characterData = characterData {
                    self.imageUriArray = []
                    self.dataArray = []
                    
                    self.characterName.text = characterData.name
                    self.characterDescription.text = characterData.description
                    self.setCharacterImage(imageURL: characterData.imageURI)
                    self.imageUriArray.append(characterData.imageURI)
                    self.setComicCovers(comicsUris: characterData.comics)
                    self.imageUriArray.append(contentsOf: characterData.comics)
                    
                    if CharacterViewModel.exists(name: characterData.name) {
                        self.charaterSaved.toggle()
                        self.saveButton.setImage(UIImage(named: "favorite"), for: .normal)
                    } else {
                        self.charaterSaved.toggle()
                        self.saveButton.setImage(UIImage(named: "unfavorite"), for: .normal)
                    }
                } else {
                    self.searchingMode = false
                }
            })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
        if (!searchingMode && searchBar.text?.count ?? 0 > 0) {
            self.showErrorAlert(title: "Error", message: "Character Not found")
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        characterInfoSubscriber?.cancel()
        comicCoversSubscriber?.cancel()
        characterImageSubscriber?.cancel()
    }
}

extension HomeViewController: iCarouselDataSource {
    
    // MARK: - iCarousel Delegate
    func numberOfItems(in carousel: iCarousel) -> Int {
        return dataArray.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: origin, y: origin, width: self.carouselContainer.frame.width/2, height: self.carouselContainer.frame.height - margin))
        view.backgroundColor = .red
        
        if dataArray.count > 0 {
            let comicImage = UIImageView(frame: view.bounds)
            
            view.addSubview(comicImage)
            comicImage.contentMode = .scaleAspectFill
            comicImage.image = UIImage(data: dataArray[index])
        }
        return view
    }
}
