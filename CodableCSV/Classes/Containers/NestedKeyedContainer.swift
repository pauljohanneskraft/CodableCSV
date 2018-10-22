//
//  NestedKeyedContainer.swift
//  CodableCSV
//
//  Created by Paul Kraft on 20.08.18.
//

import Foundation

final class CSVNestedKeyedContainer<Key: CodingKey> {
    var superKey: String
    var superContainer: CSVContainer
    var nesting: CSVNesting

    init(superKey: String, superContainer: CSVContainer, nesting: CSVNesting) {
        self.superContainer = superContainer
        self.superKey = superKey
        self.nesting = nesting
    }
}

extension CSVNestedKeyedContainer: CSVContainer {
    lazy var dictionary: [String : String] = {
        var dict = [String: String]()
        for (key, value) in superContainer.dictionary {
            guard key.hasPrefix(superKey)
        }
    }()

    var decoders: DecoderDictionary {
        return superContainer.decoders
    }

    var encoders: EncoderDictionary {
        return superContainer.encoders
    }
}

extension CSVNestedKeyedContainer: KeyedDecodingContainerProtocol {
    var codingPath: [CodingKey] {
        return allKeys
    }

    var allKeys: [Key] {
        let keys = superContainer.dictionary.keys.compactMap { key -> Key? in
            guard key.hasPrefix(superKey) else { return nil }
            let string = String(key.dropFirst(superKey.count + 1))
            return Key(stringValue: string)
        }
        return Array(keys)
    }

    func contains(_ key: Key) -> Bool {
        return superContainer.dictionary.keys.contains(superKey + "." + key.stringValue)
    }

    private func value(forKey key: Key) throws -> String {
        guard let data = superContainer.dictionary[superKey + "." + key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        return data
    }

    private func decode<C: Decodable>(_ string: String, using decoder: @escaping (String) -> C?) throws -> C {
        let decode = superContainer.decoders[C.identifier] ?? decoder
        guard let value = decode(string) as? C else {
            throw CSVCodingError.couldNotDecode(string, as: C.self)
        }
        return value
    }

    private func decode<C: Decodable>(using generate: @escaping (String) -> C?, forKey key: Key) throws -> C {
        return try decode(try value(forKey: key), using: generate)
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        // <#code#>
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        return try decode(using: type.init, forKey: key)
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        return try decode(using: type.init, forKey: key)
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        return try decode(using: { string in
            guard let data = string.data(using: .utf8) else { return nil }
            return try? JSONDecoder().decode(type, from: data)
        }, forKey: key)
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        // <#code#>
        let container = CSVNestedKeyedContainer(superKey: superKey + "." + key.stringValue, superContainer: self, nesting: nesting)
    }

    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        // <#code#>
    }

    func superDecoder() throws -> Decoder {
        // <#code#>
    }

    func superDecoder(forKey key: Key) throws -> Decoder {
        // <#code#>
    }
}
