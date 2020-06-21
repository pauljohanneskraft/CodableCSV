//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

import Foundation

struct UnkeyedDecoder: DecodingContainer {

    let storage: DecodingStorage
    let codingPath: [CodingKey]
    var currentIndex = 0

}

extension UnkeyedDecoder: UnkeyedDecodingContainer {

    var count: Int? {
        nil
    }

    var isAtEnd: Bool {
        guard let key = try? storage.key(index: currentIndex) else {
            return true
        }
        return storage.isAtEnd(codingPath: codingPath + [key])
    }

    mutating func decode<T : Decodable>(_ type: T.Type) throws -> T {
        defer { currentIndex += 1 }
        let index = try storage.key(index: currentIndex)
        let decoder = SingleValueDecoder(storage: storage, codingPath: codingPath + [index])
        return try decoder.decode(T.self)
    }

    mutating func decodeNil() throws -> Bool {
        defer { currentIndex += 1 }
        let index = try storage.key(index: currentIndex)
        let decoder = SingleValueDecoder(storage: storage, codingPath: codingPath + [index])
        return decoder.decodeNil()
    }

    mutating func nestedContainer<NestedKey: CodingKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> {
        defer { currentIndex += 1 }
        let key = try storage.key(index: currentIndex)
        let decoder = KeyedDecoder<NestedKey>(storage: storage, codingPath: codingPath + [key])
        return KeyedDecodingContainer(decoder)
    }

    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        defer { currentIndex += 1 }
        let key = try storage.key(index: currentIndex)
        return UnkeyedDecoder(storage: storage, codingPath: codingPath + [key])
    }

    mutating func superDecoder() throws -> Decoder {
        UnkeyedDecoder(storage: storage, codingPath: codingPath)
    }

}
