//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

import Foundation

private struct WordStrategy: NoneStrategy {

    let word: String

    func encodeNil(codingPath: [CodingKey]) throws -> String {
        word
    }

    func decodeNil(_ string: String, codingPath: [CodingKey]) throws -> Bool {
        string == word
    }

}

extension CSVNone {

    public static let null: CSVNone = "null"
    public static let `nil`: CSVNone = "nil"

    public static func word(_ word: String) -> CSVNone {
        CSVNone(strategy: WordStrategy(word: word))
    }

}

extension CSVNone: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self = .word(value)
    }

}
