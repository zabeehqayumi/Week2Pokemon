//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Kevin Yu on 8/14/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

import Foundation

class Pokemon: Decodable {
    
    var name: String!
    var species: [String:String]!
    var sprites: Sprite!        // a Decodable class can have Decodable classes as properties

    // can set up coding keys to change names of properties from response
    // var metaInfo: [String:String]!
    /*
    enum CodingKeys: String, CodingKey {
        case name
        case metaInfo = "species"
    }
    */
}

// structs can also be decodable
struct Sprite: Decodable {
    var back_female: String!
    var back_shiny_female: String!
    var back_default: String!
    var front_female: String!
    var front_shiny_female: String!
    var front_default: String!
    var front_shiny: String!
    
    // codingKeys would be good to have here, for camelCase-variable-naming conventions
}
