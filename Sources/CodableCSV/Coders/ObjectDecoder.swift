//
//  ObjectDecoder.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

final class CSVObjectDecoder {

    // MARK: Stored Properties

    let dictionary: [String: String]
    
    private let decoders: DecoderDictionary

    // MARK: Computed Properties

    var codingPath: [CodingKey] {
        return []
    }

    var userInfo: [CodingUserInfoKey : Any] {
        return [:]
    }

    // MARK: Initialization

    init(headers: [String], values: [String], decoders: DecoderDictionary) throws {
        guard headers.count == values.count else {
            throw CSVCodingError.headerMismatch
        }
        var dictionary = [String: String]()
        for i in headers.indices {
            dictionary[headers[i]] = values[i]
        }
        self.decoders = decoders
        self.dictionary = dictionary
    }

}

// MARK: - Extension: Decoder

extension CSVObjectDecoder: Decoder {

    func container<Key: CodingKey>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> {
        let container = CSVKeyedContainer<Key>()
        container.dictionary = dictionary
        container.decoders = decoders
        return KeyedDecodingContainer(container)
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        throw CSVCodingError.unkeyedNotSupported
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        throw CSVCodingError.unkeyedNotSupported
    }

}
