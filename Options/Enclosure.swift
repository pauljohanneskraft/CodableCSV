//
//  Enclosure.swift
//  CodableCSV
//
//  Created by Paul Kraft on 19.08.18.
//

import Foundation

public struct CSVEnclosure {

    // MARK: - Stored properties

    public let begin: String
    public let end: String

    // MARK: - Computed properties

    // MARK: - Init

    private init(begin: String, end: String) {
        self.begin = begin
        self.end = end
    }

    // MARK: - Static properties

    public static let `default` = doubleQuotes
    public static let singleQuotes = CSVEnclosure(begin: "\'", end: "\'")
    public static let accentAigu = CSVEnclosure(begin: "´", end: "´")
    public static let accentGrave = CSVEnclosure(begin: "`", end: "`")
    public static let doubleQuotes = CSVEnclosure(begin: "\"", end: "\"")
    public static let roundBrackets = CSVEnclosure(begin: "(", end: ")")
    public static let squareBrackets = CSVEnclosure(begin: "[", end: "]")

    // MARK: - Static functions

    public static func custom(begin: String, end: String) -> CSVEnclosure {
        return .init(begin: begin, end: end)
    }
}
