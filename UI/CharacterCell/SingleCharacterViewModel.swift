//
//  CharacterSingleViewModel.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation

protocol CharacterSingleViewModelDelegate: CharacterTableViewCell {
    func configCell(with character: Attributes)
}
class SingleCharacterViewModel {
    
// MARK: - Properties
    
  
     private weak var delegate: CharacterSingleViewModelDelegate?
    
   
    var characterData: CharacterDataDictionary
    var fetchedCharacter: CharacterData?
    var service: SingleCharacterServiceable
    
    
    // MARK: - Dependency Injection
    init(injectedDelegate: CharacterSingleViewModelDelegate, characterData: CharacterDataDictionary, injectedCharacterSingleService: SingleCharacterServiceable = SingleCharacterService()) {
        self.delegate = injectedDelegate
        self.characterData = characterData
        self.service = injectedCharacterSingleService

        fetchSingleCharacter()
    }
   
    func fetchSingleCharacter() {
        
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
        
    }

} 
