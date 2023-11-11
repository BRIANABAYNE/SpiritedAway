//
//  CharacterListService.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation

/// Protocol used to `abstract` or `remove`the concrete connection of this service and any class or struct that needs access to it
///
/// We are using this becasue it follows SOLID that is part of Model View, View Model design patern. We are abstracting the data to create a non concrete connection. Protocols and delegates are a 1:1 commuincation and they are an abstraction. It is best practice to use concrete with abstaction instead of conrete with a conrete object.
protocol CharacterListServiceable {
    func fetchCharacters(callback: @escaping (Result<TopLevelDictionary, NetworkingError>) -> Void)
}
// This struct is adopting the APIDataProvidable and CharacterListSericable 
struct CharacterListService: APIDataProvidable, CharacterListServiceable {
    
    /// We are only looking for the characters from Spritied Away. TODO: - Update to fetch charactes for any anime.
    /// We are fetching multiple characters with this fetch. This function is fetching the characters, asking for a call back that is letting us know when the completion has finished. We are asking for two different types of results, sucess and failure. Sucess would be the information in our model and failure would be a networking error. We have a custom error becasue we created it in another file to handle all our custom errors.
    func fetchCharacters(callback: @escaping (Result<TopLevelDictionary, NetworkingError>) -> Void) {
        // Compose the URL - this is where we create the base URL, components, and query items. We didn't add any compoents or query items for this API but this will alway change per API. Compoents will have / and quary items start with ?
        guard let finalURL = URL(string: "https://kitsu.io/api/edge/anime/176/characters") else {callback(.failure(.invalidURL)); return}
        let urlRequest = URLRequest(url: finalURL)
        // DataTask
        perform(urlRequest) { result in
            switch result {
            case .success(let allCharactersData):
                //  To decode the data, we are using a do, try, chatch to make sure the data is decdoing correctly from the API. We have to use this becasue we are throwing the information to the internet and we need to catch it. We are using JSONDecoder.decdode to decode information in our TLD from all the character data.
                do {
                    let decodedTLD = try JSONDecoder().decode(TopLevelDictionary.self, from: allCharactersData)
                    callback(.success(decodedTLD)) // This will come back if we were correct with our model and all information we have created.
                } catch {
                    callback(.failure(.thrownError(error))) // Thrown Error is another custom error that we created. This will come back if there was an issue.
                }
            case .failure(_):
                callback(.failure(.unableToDecode)) // Unable to decode is another custom error and this is saying that we weren't able to decode the data.
            }
        }
    }
}
