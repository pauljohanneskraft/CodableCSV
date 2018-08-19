//
//  Delimiter.swift
//  CodableCSV
//
//  Created by Paul Kraft on 19.08.18.
//

import Foundation

public struct CSVDelimiter {

    // MARK: - Stored properties

    public let character: Character

    // MARK: - Computed properties

    var stringValue: String {
        return String(character)
    }

    // MARK: - Init

    private init(character: Character) {
        self.character = character
    }

    // MARK: - Static properties

    public static let newline = CSVDelimiter(character: "\n")
    public static let tab = CSVDelimiter(character: "\t")

    // MARK: - Static functions

    public static func custom(_ character: Character) -> CSVDelimiter {
        return .init(character: character)
    }
}