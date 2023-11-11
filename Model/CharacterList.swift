//
//  CharacterList.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let data : [CharacterDataDictionary]
    let meta: Meta
    let links: Links
}

struct CharacterDataDictionary: Decodable {
    let id: String
    let relationships: Relationship
}

struct Meta: Decodable {
    let count: Int
}

struct Links: Decodable {
    let first: String
    let next: String
    let last: String
}

struct Relationship: Codable {
    let character: Character
}

struct Character: Codable {
    let links: CharacterLinks
}

struct CharacterLinks: Codable {
 
    let related: String
}
