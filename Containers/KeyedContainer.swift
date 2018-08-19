//
//  KeyedContainer.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

final class CSVKeyedContainer<Key: CodingKey> {

    // MARK: - Stored properties

    var dictionary = [String: String]()

    // MARK: - Computed properties

    var codingPath: [CodingKey] {
        return allKeys
    }

    var allKeys: [Key] {
        return Array(dictionary.keys.map { Key(stringValue: $0)! })
    }
}

// MARK: - Extension: KeyedDecodingContainerProtocol

extension CSVKeyedContainer: KeyedDecodingContainerProtocol {
    func contains(_ key: Key) -> Bool {
        return dictionary.keys.contains(key.stringValue)
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        return dictionary[key.stringValue]?.isEmpty ?? true
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        return data
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        guard let value = type.init(data) else {
            throw CSVCodingError.couldNotDecode(data, as: type)
        }
        return value
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        throw CSVCodingError.couldNotDecode(data, as: T.self)
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        throw CSVCodingError.nestingNotSupported
    }

    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        throw CSVCodingError.nestingNotSupported
    }

    func superDecoder() throws -> Decoder {
        throw CSVCodingError.nestingNotSupported
    }

    func superDecoder(forKey key: Key) throws -> Decoder {
        throw CSVCodingError.nestingNotSupported
    }
}

// MARK: - Extension: KeyedEncodingContainerProtocol

extension CSVKeyedContainer: KeyedEncodingContainerProtocol {
    func encodeNil(forKey key: Key) throws {
        dictionary[key.stringValue] = ""
    }

    func encode(_ value: Bool, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: String, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: Double, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: Float, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: Int, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: Int8, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: Int16, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: Int32, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: Int64, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: UInt, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: UInt8, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: UInt16, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: UInt32, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode(_ value: UInt64, forKey key: Key) throws {
        dictionary[key.stringValue] = String(describing: value)
    }

    func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        throw CSVCodingError.couldNotEncode(T.self)
    }

    func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> {
        return KeyedEncodingContainer(CSVKeyedContainer<NestedKey>())
    }

    func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        assertionFailure("\(CSVCodingError.nestingNotSupported).")
        return CSVUnkeyedEncodingContainer()
    }

    func superEncoder() -> Encoder {
        assertionFailure("\(CSVCodingError.nestingNotSupported).")
        return CSVObjectEncoder()
    }

    func superEncoder(forKey key: Key) -> Encoder {
        assertionFailure("\(CSVCodingError.nestingNotSupported).")
        return CSVObjectEncoder()
    }
}
