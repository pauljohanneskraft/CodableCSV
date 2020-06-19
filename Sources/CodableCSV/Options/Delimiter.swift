//
//  Delimiter.swift
//  CodableCSV
//
//  Created by Paul Kraft on 19.08.18.
//

import Foundation

public struct CSVDelimiter {

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

    // MARK: Static Properties

    public static let `default` = newline
    public static let newline = CSVDelimiter(character: "\n")
    public static let tab = CSVDelimiter(character: "\t")

    // MARK: Static Functions

    public static func custom(_ character: Character) -> CSVDelimiter {
        return .init(character: character)
    }

}
