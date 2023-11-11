//
//  CharacterSingleDetailViewController.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 7/2/23.
//

import UIKit

class SingleCharacterDetailViewController: UIViewController {

    // MARK: - Functions
    
    @IBOutlet weak var singleCharacterNameLabel: UILabel!
    @IBOutlet weak var singleChatacterImage: UIImageView!
    @IBOutlet weak var singleCharacterDescriptionLabel: UILabel!
   
    // MARK: - Property
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(with chatacter: CharacterData, image: UIImage) {
        loadViewIfNeeded()
        self.singleCharacterNameLabel.text = chatacter.attributes.canonicalName
        self.singleChatacterImage.image = image
        self.singleCharacterDescriptionLabel.text = chatacter.attributes.description
    }

}
