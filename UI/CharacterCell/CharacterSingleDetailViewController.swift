//
//  CharacterSingleDetailViewController.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 7/2/23.
//

import UIKit

// I'm feeling a little all over the place with this project. I understand the detail page but I don't understand with using MVVM design pattern. I was thinking that all the information I was writing on the viewcell was everything I needed. I'm a little confused by some of the comments Esther made when saying that the first nextwork call wans't going to display any information and so everything would be done on the viewCell. Sorry I'm not in a better place with all of this but I feel like I'm combining topics.

class CharacterSingleDetailViewController: UIViewController {

    // MARK: - Functions
    
 // Outlets the user will be seing to display all the singel character information.
    @IBOutlet weak var singleCharacterNameLabel: UILabel!
    @IBOutlet weak var singleChatacterImage: UIImageView!
    @IBOutlet weak var singleCharacterDescriptionLabel: UILabel!


    // Having the viewmodel talk to the "CSDVC"
//    var viewModel: CharacterSingleDetailViewController?
    
    
   // MARK: - Property
//    var character: Character? MVC BLeH
    

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
