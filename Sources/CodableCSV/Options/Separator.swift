//
//  Separator.swift
//  CodableCSV
//
//  Created by Paul Kraft on 19.08.18.
//

import Foundation

public struct CSVSeparator {

    // MARK: Static Properties

    public static let `default` = comma
    public static let comma = custom(",")
    public static let colon = custom(";")

    // MARK: Static Functions

    public static func custom(_ character: Character) -> CSVSeparator {
        .init(character: character)
    }

    // MARK: Stored Properties

    public let character: Character

    // MARK: Computed Properties

    var stringValue: String {
        return String(character)
    }

    // MARK: Initialization

    private init(character: Character) {
        self.character = character
    }

}
