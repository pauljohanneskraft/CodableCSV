//
//  Nesting.swift
//  CodableCSV
//
//  Created by Paul Kraft on 20.08.18.
//

import Foundation

public struct CSVNesting {

    // MARK: - Static properties

    public static let `default` = unsupported
    private static let unsupported = CSVNesting() // throws errors when trying to nest
    private static let flat = CSVNesting() // creates additional headers for nested arrays
    private static let json = CSVNesting() // encodes nested types using json
    private static let nestedCSV = CSVNesting() // uses CSV to nest files

    // MARK: - Static functions

    // adds additional headers by concatenating header titles, such as
    //
    // JSON: {"a": {"b":"c", "d": "e"}}
    //
    // is represented as
    //
    // CSV: a.b, a.d
    // CSV: c, e
    private static func separated(by character: Character) -> CSVNesting {
        return CSVNesting()
    }
}
