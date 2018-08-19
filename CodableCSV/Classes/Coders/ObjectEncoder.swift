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
    var encoders: EncoderDictionary

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

    // MARK: - Init

    init(encoders: EncoderDictionary) {
        self.encoders = encoders
    }
}

// MARK: - Extension: Encoder

extension CSVObjectEncoder: Encoder {
    func container<Key: CodingKey>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
        let container = CSVKeyedContainer<Key>()
        self.container = container
        container.encoders = encoders
        return KeyedEncodingContainer(container)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        return CSVUnkeyedEncodingContainer()
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        return CSVSingleValueContainer()
    }
}
