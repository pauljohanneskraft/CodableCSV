//
//  Options.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

public enum CSVSeparatorSymbol {
    case comma
    case colon
    case custom(Character)

    var stringValue: String {
        return String(character)
    }

    var character: Character {
        switch self {
        case .colon:
            return ";"
        case .comma:
            return ","
        case .custom(let character):
            return character
        }
    }
}
