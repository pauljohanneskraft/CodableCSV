//
//  Delimiter.swift
//  CodableCSV
//
//  Created by Paul Kraft on 19.08.18.
//

public struct CSVDelimiter {

    // MARK: Static Properties

    public static let `default` = lineFeed

    public static let lineFeed = custom("\n")
    public static let carriageReturn = custom("\r")
    public static let endOfLine = custom("\r\n")

    public static let tab = custom("\t")

    // MARK: Static Functions

    public static func custom(_ character: Character) -> CSVDelimiter {
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
