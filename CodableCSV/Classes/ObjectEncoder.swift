//
//  ObjectEncoder.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

final class CSVObjectEncoder {

    // MARK: - Stored properties

    var container: CSVContainer?

    // MARK: - Computed properties

    var userInfo: [CodingUserInfoKey : Any] {
        return [:]
    }

    var codingPath: [CodingKey] {
        return container?.codingPath ?? []
    }

    var dictionary: [String: String] {
        return container?.dictionary ?? [:]
    }
}

// MARK: - Extension: Encoder

extension CSVObjectEncoder: Encoder {
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        let container = CSVKeyedContainer<Key>()
        self.container = container
        return KeyedEncodingContainer(container)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("\(#function) not supported.")
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        return CSVSingleValueContainer(codingPath: [], data: "")
    }
}
