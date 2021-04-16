//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

public protocol NoneStrategy {
    func encodeNil(codingPath: [CodingKey]) throws -> String
    func decodeNil(_ string: String, codingPath: [CodingKey]) -> Bool
}

public struct CSVNone {

    // MARK: Static Properties

    public static let `default` = empty

    // MARK: Stored Properties

    public let strategy: NoneStrategy

    // MARK: Initialization

    public init(strategy: NoneStrategy) {
        self.strategy = strategy
    }

}
