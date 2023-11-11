//
//  CharacterListViewModel.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation

protocol CharacterListViewModelDelegate: CharacterListTableViewController {
    func characterListFetchedSuccessfully()
}


class CharacterListViewModel {
    
   
    weak var delegate: CharacterListViewModelDelegate?
    
    // MARK: - Properties

    var characterList: [CharacterDataDictionary] = []
    var service: CharacterListServiceable
    
 // MARK: - Depedency Injection
    init(injectedDelegate: CharacterListViewModelDelegate, injectedCharacterService: CharacterListServiceable = CharacterListService()) {
        self.delegate = injectedDelegate
        self.service = injectedCharacterService
        fetchCharacterList()
    }
 
    func fetchCharacterList() {
        service.fetchCharacters { result in
            switch result {
            case .success(let tld):
                self.characterList = tld.data
                self.delegate?.characterListFetchedSuccessfully()
            case .failure(let failure):
                print(failure.errorDescription!)
            }
        }
    }
}
