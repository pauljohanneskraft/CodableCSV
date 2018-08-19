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
    private static let unsupported = CSVNesting()
    private static let flat = CSVNesting()
    private static let json = CSVNesting()
    private static let nestedCSV = CSVNesting()

    // MARK: - Static functions

    private static func separated(by character: Character) -> CSVNesting {
        return CSVNesting()
    }
}
