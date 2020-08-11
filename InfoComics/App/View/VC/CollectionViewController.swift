//
//  HomeViewController.swift
//  InfoComics
//
//  Created by Pjcyber on 7/5/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import UIKit
import Combine

class CollectionViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var chacterCollectionView: UICollectionView!
    
    // MARK: - Variables
    internal var characters: [Character] = []
    internal var charactersSubscriber: AnyCancellable?
    
    
    // MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getCharactersData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
    
    func getCharactersData() {
        charactersSubscriber = CollectionViewModel.getCharacter()
            .sink(receiveCompletion: { error in
            }, receiveValue: { charatersData in
                self.characters = []
                self.characters.append(contentsOf: charatersData)
            })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CharacterDetailsViewController
        let character = sender as! Character
        vc.character = character
    }
    
}
extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuViewCell.menuCellIdentifier, for: indexPath) as! MenuViewCell
        if  characters.count > 0 {
            let character = characters[indexPath.row]
            cell.backgroundImage.image = UIImage(data: characters[indexPath.row].getImage()!)
            cell.label.text = character.name
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetail", sender: characters[indexPath.row])
    }
}
