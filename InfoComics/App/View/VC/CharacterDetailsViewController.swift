//
//  CharacterDetailsViewController.swift
//  InfoComics
//
//  Created by Pjcyber on 8/8/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import UIKit
import iCarousel

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - Constants
    let margin: CGFloat = 20
    let origin: CGFloat = 10
    let comicCarousel: iCarousel = {
        let view = iCarousel()
        view.type = .coverFlow
        return view
    }()
    
    // MARK: - Variables
    internal var character: Character?
    internal var comicCovers: [Data] = []
    
    // MARK: - Outlets
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var comicsCarouselContainer: UIView!
    
    // MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comicsCarouselContainer.addSubview(comicCarousel)
        comicCarousel.dataSource = self
        comicCarousel.frame = CGRect(x: origin, y: origin, width: self.comicsCarouselContainer.frame.width-margin, height: self.comicsCarouselContainer.frame.height-margin)
        
        if let character =  self.character {
            name.text = character.name
            details.text = character.description
            image.image = UIImage(data: character.getImage()!)
            if character.covers.count > 1 {
                comicCovers.append(contentsOf: character.covers)
                comicCarousel.reloadData()
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
    
}

extension CharacterDetailsViewController: iCarouselDataSource {
    
    // MARK: - iCarousel Delegate
    func numberOfItems(in carousel: iCarousel) -> Int {
        return comicCovers.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: origin, y: origin, width: self.comicsCarouselContainer.frame.width/2, height: self.comicsCarouselContainer.frame.height - margin))
        view.backgroundColor = .red
        
        if comicCovers.count > 0 {
            let comicImage = UIImageView(frame: view.bounds)
            
            view.addSubview(comicImage)
            comicImage.contentMode = .scaleAspectFill
            comicImage.image = UIImage(data: comicCovers[index])
        }
        return view
    }
}
