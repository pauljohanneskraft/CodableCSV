//
//  Options.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

public struct CSVSeparatorSymbol {

    // MARK: - Stored properties

    let character: Character

    // MARK: - Computed properties

    var stringValue: String {
        return String(character)
    }

    // MARK: - Init

    private init(character: Character) {
        self.character = character
    }

    // MARK: - Static properties

    public static let comma = CSVSeparatorSymbol(character: ",")
    public static let colon = CSVSeparatorSymbol(character: ";")

    // MARK: - Static functions

    public static func custom(_ character: Character) -> CSVSeparatorSymbol {
        return .init(character: character)
    }
}
