//
//  Nesting.swift
//  CodableCSV
//
//  Created by Paul Kraft on 19.08.18.
//

import Foundation

public protocol NestingStrategy {
    func nest(codingPath: [CodingKey]) -> String
    func key<Key: CodingKey>(codingPath: [CodingKey], for string: String) -> Key?
}

public struct CSVNesting {

    // MARK: Static Properties

    static let `default` = flatten

    // MARK: Stored Properties

    public let strategy: NestingStrategy

    // MARK: Initialization

    public init(strategy: NestingStrategy) {
        self.strategy = strategy
    }

}
