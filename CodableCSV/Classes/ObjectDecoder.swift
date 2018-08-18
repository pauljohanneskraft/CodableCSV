//
//  ObjectDecoder.swift
//  SwiftyCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

final class CSVObjectDecoder {

    // MARK: - Stored properties

    let dictionary: [String: String]

    // MARK: - Computed properties

    var codingPath: [CodingKey] {
        return []
    }

    var userInfo: [CodingUserInfoKey : Any] {
        return [:]
    }

    // MARK: - Init

    init(headerFields: [String], string: String, separatorSymbol: Character) {
        let split = string.split(separator: separatorSymbol)
        var dictionary = [String: String]()
        for i in headerFields.indices {
            dictionary[headerFields[i]] = String(split[i])
        }
        self.dictionary = dictionary
    }
}

extension CSVObjectDecoder: Decoder {
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        let container = CSVKeyedContainer<Key>()
        container.dictionary = dictionary
        return KeyedDecodingContainer(container)
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        fatalError("\(#function) not supported.")
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        return CSVSingleValueContainer(codingPath: [], data: "")
    }
}
