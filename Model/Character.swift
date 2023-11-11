//
//  Character.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation

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
