//
//  CharacterListViewModel.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation
// Protocals always go above a class or struct! We are delcairling a delegate
protocol CharacterListViewModelDelegate: CharacterListTableViewController {
    func characterListFetchedSuccessfully() // our function that we created that will let us know that the fetch was sucessful and that we can move forward.
}
// We turned this struct into a class to make it not a concrete object and a refernce type instead of a value type.

class CharacterListViewModel {
    
    // What are our goals. What should the view model do (functions) and what should it hold (properties)
    weak var delegate: CharacterListViewModelDelegate?
    
    // MARK: - Properties
    // sot - always us to gain access we need.
    // This will be filled with all the characters after the fetch succeded
    var characterList: [CharacterDataDictionary] = []
    var service: CharacterListServiceable
    
    // DEPENDENCY INJECTION
    init(injectedDelegate: CharacterListViewModelDelegate, injectedCharacterService: CharacterListServiceable = CharacterListService()) {
        self.delegate = injectedDelegate
        self.service = injectedCharacterService
        fetchCharacterList()
    }
    // Fetching the characterlist 
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
