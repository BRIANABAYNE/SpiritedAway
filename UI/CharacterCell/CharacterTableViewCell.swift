//
//  CharacterTableViewCell.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    var viewModel: CharacterSingleViewModel? // this will be used on cell for row at to connect viewmodels init to identif the parm need to match the information for self for row at
    
    
    // MARK: - Outlets
    // These outlets are what we placed on the cell on the tableview. These outlets will be seen by the user.
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var characterImageView: ServiceRequestingImageView!
    
    // MARK: - Properties
//    let character: Character?
    
    
// function to fetch the image with a url string. My goal with this was to 
    private func fetchImage(with url: String ) {
        guard let imageURL = URL(string: url) else {return}
        characterImageView.fetchImage(from:imageURL)
    }
}


// This extension will talk to the cell viewmodel, it will config the data. Extensions are always outside the scope of the TableViewCell.
extension CharacterTableViewCell: CharacterSingleViewModelDelegate {
    func characterLoadedSuccessfully() {
        viewModel?.fetchSingleCharacter()
    }
    // We are using "Attributes " from our struct model to gain the correct information we are looking for one character. This is where we are giving the outlets a text property and using dot syntax to get to the correct property. // Esther was giving me some hints on this but don't really understand.
    func configCell(with character: Attributes ) {
        DispatchQueue.main.async {
            self.characterNameLabel.text = character.canonicalName
            self.characterDescriptionLabel.text = character.description
            self.fetchImage(with: character.imageDictionary.original)
        }
    }
}
