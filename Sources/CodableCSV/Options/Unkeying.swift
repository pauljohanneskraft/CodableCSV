//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

import Foundation

public struct CSVUnkeying {

    // MARK: Static Properties

    public static let `default` = integer

    // MARK: Stored Properties

    private let keyForIndex: (Int) throws -> CodingKey

    // MARK: Initialization

    public init(keyForIndex: @escaping (Int) throws -> CodingKey) {
        self.keyForIndex = keyForIndex
    }

    // MARK: Methods

    public func key(forIndex index: Int) throws -> CodingKey {
        try keyForIndex(index)
    }

}
