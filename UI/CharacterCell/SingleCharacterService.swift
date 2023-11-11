//
//  CharacterSingleService.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation


protocol SingleCharacterServiceable {
    func fetchSingleCharacter(with url: String, callback: @escaping (Result<CharacterTopLevelDictionary, NetworkingError>) -> Void)
}


struct SingleCharacterService: APIDataProvidable, SingleCharacterServiceable {
    
    func fetchSingleCharacter(with url: String, callback: @escaping (Result<CharacterTopLevelDictionary, NetworkingError>) -> Void) {
        
        guard let finalURL = URL(string: url)
        else { callback(.failure(.invalidURL)); return }
        let urlRequest = URLRequest(url: finalURL)
      
        perform(urlRequest) { result in
            switch result {
            case.success(let singleCharacterData):
               
                do {
                    let decodedSingleCharacter = try JSONDecoder().decode(CharacterTopLevelDictionary.self, from: singleCharacterData)
                    callback(.success(decodedSingleCharacter))
                } catch {
                    callback(.failure(.thrownError(error)))
                }
            case.failure(_):
                callback(.failure(.unableToDecode))
                
            }
        }
    }
    
}
