//
//  CharacterSingleViewModel.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation


// This is the ViewModel for characterCell that is getting us one character information. This file holds business logic for tableViewCell.

// Adding the protocol above the class per our best practice. This delegate will be talking to the CharacterTablewViewCell. We are also abstracting here with the protocol/ delegate to create non concrete object.
protocol CharacterSingleViewModelDelegate: CharacterTableViewCell {
    func configCell(with character: Attributes) // We are creating this function that will config the cell to gain access from the attributes on our model to gain the correct information we hoping to display in the cell on the UI for the user to see the information.
//    func characterLoadedSuccessfully() // Created function to know that the information loaded sucessfully
    
}

// This started as a struct but changed to a class.
class CharacterSingleViewModel {
    
// MARK: - Properties
    
    // delegate be type character"" Delegate
     private weak var delegate: CharacterSingleViewModelDelegate?
    
    // creating a property characterData be type CharacterData
    var characterData: CharacterDataDictionary // character list
    var fetchedCharacter: CharacterData? // character
    var service: CharacterSingleServiceable
    
    // Injected initialzier
    init(injectedDelegate: CharacterSingleViewModelDelegate, characterData: CharacterDataDictionary, injectedCharacterSingleService: CharacterSingleServiceable = CharacterSingleService()) {
        self.delegate = injectedDelegate
        self.characterData = characterData
        self.service = injectedCharacterSingleService
        
        fetchSingleCharacter()
    }
    
    // func fetching one character
    func fetchSingleCharacter() {
        
        // Using dot syntax to get to the informaiton needed.
        //let singleCharacter = characterData.attributes.canonicalName
        let singleCharacterURLString = characterData.relationships.character.links.related
        
        service.fetchSingleCharacter(with: singleCharacterURLString ) { result in
             switch result {
            case .success(let character):
                 self.fetchedCharacter = character.data
                 self.delegate?.configCell(with: character.data.attributes)
            case .failure(let failure):
                print(failure.errorDescription!)
            }
        }
        
    } // end of fetch

} // end of struct
