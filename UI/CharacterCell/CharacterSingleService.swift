//
//  CharacterSingleService.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation
// https://kitsu.io/api/edge/media-characters/105018/character

// Using abstraction to gain a non concrete + concrete object to stick to SOLID. We are using Model View, View Model design pattern.

protocol CharacterSingleServiceable {
    func fetchSingleCharacter(with url: String, callback: @escaping (Result<CharacterTopLevelDictionary, NetworkingError>) -> Void)
}


struct CharacterSingleService: APIDataProvidable, CharacterSingleServiceable {
    
    // Creating the seoncd fetch function here. We are asking the fetch to use the URL string to come complete with results of success or failure. The success will be a character top level dict or a custom error.
    
    func fetchSingleCharacter(with url: String, callback: @escaping (Result<CharacterTopLevelDictionary, NetworkingError>) -> Void) {
        
        // Creating The URL
        guard let finalURL = URL(string: url)
        else { callback(.failure(.invalidURL)); return }
        let urlRequest = URLRequest(url: finalURL)
        // DataTask
        // perform the URL request
        perform(urlRequest) { result in
            switch result {
            case.success(let singleCharacterData):
                // Decoding the data with a do try catch. Using JSONdecoder to decode the CTLD from the a singlecharacterData
                do {
                    let decodedSingleCharacter = try JSONDecoder().decode(CharacterTopLevelDictionary.self, from: singleCharacterData)
                    callback(.success(decodedSingleCharacter)) // Success of decoding the data with a singleCharacter
                } catch {
                    callback(.failure(.thrownError(error))) // Failure with a custom error
                }
            case.failure(_):
                callback(.failure(.unableToDecode)) // Failure to decode the data with a custom error
                
            }
            
        }
        
    }
    
} // end of fetch
