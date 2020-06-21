//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

import Foundation

struct KeyedEncoder<Key: CodingKey>: EncodingContainer {

    let storage: EncodingStorage
    let codingPath: [CodingKey]

}

extension KeyedEncoder: KeyedEncodingContainerProtocol {

    mutating func encodeNil(forKey key: Key) throws {
        var encoder = SingleValueEncoder(storage: storage, codingPath: codingPath + [key])
        try encoder.encodeNil()
    }

    mutating func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
        var encoder = SingleValueEncoder(storage: storage, codingPath: codingPath + [key])
        try encoder.encode(value)
    }

    mutating func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type,
                                                        forKey key: Key) -> KeyedEncodingContainer<NestedKey>  {
        let encoder = KeyedEncoder<NestedKey>(storage: storage, codingPath: codingPath + [key])
        return KeyedEncodingContainer(encoder)
    }

    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        UnkeyedEncoder(storage: storage, codingPath: codingPath + [key])
    }

    mutating func superEncoder() -> Encoder {
        KeyedEncoder(storage: storage, codingPath: codingPath)
    }

    mutating func superEncoder(forKey key: Key) -> Encoder {
        KeyedEncoder(storage: storage, codingPath: codingPath + [key])
    }

}
