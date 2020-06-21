//
//  Enclosure.swift
//  CodableCSV
//
//  Created by Paul Kraft on 19.08.18.
//

import Foundation

public struct CSVEnclosure {

    // MARK: Static Properties

    public static let `default` = doubleQuotes

    public static let accentAigu = custom(begin: "´", end: "´")
    public static let accentGrave = custom(begin: "`", end: "`")

    public static let singleQuotes = custom(begin: "\'", end: "\'")
    public static let doubleQuotes = custom(begin: "\"", end: "\"")

    public static let curlyBrackets = custom(begin: "{", end: "}")
    public static let roundBrackets = custom(begin: "(", end: ")")
    public static let squareBrackets = custom(begin: "[", end: "]")

    // MARK: Static Functions

    public static func custom(begin: String, end: String) -> CSVEnclosure {
        return .init(begin: begin, end: end)
    }

    // MARK: Stored Properties

    public let begin: String
    public let end: String

    // MARK: Initialization

    private init(begin: String, end: String) {
        self.begin = begin
        self.end = end
    }

}
