//
//  CharacterList.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import Foundation


// Creating the blue print for our app by using a concrete struct that is a value type. It is always best practice to use value types over refernce types. Always start with a value type and change to a refernce type when needed.


// We are parcing the data from the JSON using codeable for decoding. Each of these structs are matching the JSON dictionaries. We are parcing the information to get to the correct data we need for our app. For this project, we had to decode this information to even get to our second model that holds most of the information we will be displaying in our app. We didn't need to use any coding keys becase we kept all the keys as they were in the JSON.

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
    // This is the URL I need to fetch the single character data
    let related: String
}
