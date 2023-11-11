//
//  CharacterTableViewCell.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    var viewModel: SingleCharacterViewModel?
    
    // MARK: - Outlets

    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var characterImageView: ServiceRequestingImageView!
    
    // MARK: - Function


    private func fetchImage(with url: String ) {
        guard let imageURL = URL(string: url) else {return}
        characterImageView.fetchImage(from:imageURL)
    }
}

// MARK: - Extension
extension CharacterTableViewCell: CharacterSingleViewModelDelegate {
    func characterLoadedSuccessfully() {
        viewModel?.fetchSingleCharacter()
    }
 
    func configCell(with character: Attributes ) {
        DispatchQueue.main.async {
            self.characterNameLabel.text = character.canonicalName
            self.characterDescriptionLabel.text = character.description
            self.fetchImage(with: character.imageDictionary.original)
        }
    }
}
