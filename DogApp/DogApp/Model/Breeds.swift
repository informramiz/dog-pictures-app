//
//  Breeds.swift
//  DogApp
//
//  Created by Ramiz Raja on 13/07/2019.
//  Copyright © 2019 Ramiz Raja. All rights reserved.
//

import Foundation

struct Breeds: Codable {
    let message: [String: [String]]
    let status: String
    
    var breedNamesList: [String] {
        return message.keys.map({$0})
    }
}
