//
//  CharacterListService.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation


protocol CharacterListServiceable {
    func fetchCharacters(callback: @escaping (Result<TopLevelDictionary, NetworkingError>) -> Void)
}

struct CharacterListService: APIDataProvidable, CharacterListServiceable {
    

    func fetchCharacters(callback: @escaping (Result<TopLevelDictionary, NetworkingError>) -> Void) {
     
        guard let finalURL = URL(string: "https://kitsu.io/api/edge/anime/176/characters") else {callback(.failure(.invalidURL)); return}
        let urlRequest = URLRequest(url: finalURL)
        // DataTask
        perform(urlRequest) { result in
            switch result {
            case .success(let allCharactersData):
             
                do {
                    let decodedTLD = try JSONDecoder().decode(TopLevelDictionary.self, from: allCharactersData)
                    callback(.success(decodedTLD))
                } catch {
                    callback(.failure(.thrownError(error)))
                }
            case .failure(_):
                callback(.failure(.unableToDecode)) 
            }
        }
    }
}
