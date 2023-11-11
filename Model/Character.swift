//
//  Character.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation


// This struct is our second model that is getting us one character. We have to use coding keys on attributes becasue we changed the keys from the JSON. You can change any key but you have to make sure the information is available becasue it will not decode if not. Always double check for spelling and copy and paste when possible. 

struct CharacterTopLevelDictionary: Decodable {
    
    let data: CharacterData
}

struct CharacterData: Decodable {
    let id: String
    let attributes: Attributes
}

struct Attributes: Decodable {
    private enum CodingKeys: String, CodingKey {
        case canonicalName
        case imageDictionary = "image"
        case characterID = "malId"
        case description
        
    }
    
    let canonicalName: String
    let imageDictionary: ImageDictionary
    let characterID: Int
    let description: String
    
}

struct ImageDictionary: Decodable {
    // The Image URL I need to use for my image fetch
    let original: String
}
