//
//  Separator.swift
//  CodableCSV
//
//  Created by Paul Kraft on 19.08.18.
//

import Foundation

public struct CSVSeparator {

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

    public static let comma = CSVSeparator(character: ",")
    public static let colon = CSVSeparator(character: ";")

    // MARK: - Static functions

    public static func custom(_ character: Character) -> CSVSeparator {
        return .init(character: character)
    }
}

// MARK: - Extension: Detection

extension CSVSeparator {
    public static func detect(from data: Data, encoding: String.Encoding = .utf8, possibleCharacters: Set<Character> = [",", ";"], delimiter: CSVDelimiter = .newline, enclosure: CSVEnclosure = .doubleQuotes) -> CSVSeparator? {
        guard let string = String(data: data, encoding: encoding) else { return nil }
        return detect(from: string, possibleCharacters: possibleCharacters, delimiter: delimiter, enclosure: enclosure)
    }

    public static func detect(from string: String, possibleCharacters: Set<Character> = [",", ";"], delimiter: CSVDelimiter = .newline, enclosure: CSVEnclosure = .doubleQuotes) -> CSVSeparator? {
        let rows = string.split(separator: delimiter.character)
        guard rows.count > 0 else { return nil }
        for character in possibleCharacters {
            guard let columnCount = try? rows.map({ row in
                try CSVDecoder.split(row: row, separator: .custom(character), enclosure: enclosure).count
            }) else {
                continue
            }
            let optimalColumnCount = columnCount[0]
            guard optimalColumnCount > 1, !columnCount.contains(where: { $0 != optimalColumnCount }) else {
                continue
            }
            return .init(character: character)
        }
        return nil
    }
}
