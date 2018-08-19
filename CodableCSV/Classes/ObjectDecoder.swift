//
//  ObjectDecoder.swift
//  CodableCSV
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

    init(headerFields: [String], string: String, separatorSymbol: Character) throws {
        let split = string.split(separator: separatorSymbol, omittingEmptySubsequences: false)
        guard split.count == headerFields.count else {
            throw CSVCodingError.nestingNotSupported
        }
        var dictionary = [String: String]()
        for i in headerFields.indices {
            dictionary[headerFields[i]] = String(split[i])
        }
        self.dictionary = dictionary
    }
}

extension CSVObjectDecoder: Decoder {
    func container<Key: CodingKey>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> {
        let container = CSVKeyedContainer<Key>()
        container.dictionary = dictionary
        return KeyedDecodingContainer(container)
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        throw CSVCodingError.unkeyedNotSupported
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        throw CSVCodingError.unkeyedNotSupported
    }
}
