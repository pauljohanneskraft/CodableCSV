//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

import Foundation

struct UnkeyedEncoder: EncodingContainer {

    let storage: EncodingStorage
    let codingPath: [CodingKey]
    private(set) var count: Int = 0

}

extension UnkeyedEncoder: UnkeyedEncodingContainer {

    mutating func encodeNil() throws {
        defer { count += 1 }
        let index = try storage.key(index: count)
        var encoder = SingleValueEncoder(storage: storage, codingPath: codingPath + [index])
        try encoder.encodeNil()
    }

    mutating func encode<T: Encodable>(_ value: T) throws {
        defer { count += 1 }
        let index = try storage.key(index: count)
        var encoder = SingleValueEncoder(storage: storage, codingPath: codingPath + [index])
        try encoder.encode(value)
    }

    mutating func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> {
        let encoder = KeyedEncoder<NestedKey>(storage: storage, codingPath: codingPath)
        return KeyedEncodingContainer(encoder)
    }

    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        UnkeyedEncoder(storage: storage, codingPath: codingPath)
    }

    mutating func superEncoder() -> Encoder {
        UnkeyedEncoder(storage: storage, codingPath: codingPath, count: count)
    }

}
