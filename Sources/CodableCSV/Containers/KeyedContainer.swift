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
    var decoders = DecoderDictionary()
    var encoders = EncoderDictionary()

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
        return try decode(using: Bool.init, forKey: key)
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        return try value(forKey: key)
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        return try decode(using: Double.init, forKey: key)

    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        return try decode(using: Float.init, forKey: key)
    }

    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        return try decode(using: Int.init, forKey: key)
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        return try decode(using: Int8.init, forKey: key)
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        return try decode(using: Int16.init, forKey: key)
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        return try decode(using: Int32.init, forKey: key)
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        return try decode(using: Int64.init, forKey: key)
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        return try decode(using: UInt.init, forKey: key)
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        return try decode(using: UInt8.init, forKey: key)
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        return try decode(using: UInt16.init, forKey: key)
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        return try decode(using: UInt32.init, forKey: key)
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        return try decode(using: UInt64.init, forKey: key)
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        let data = try value(forKey: key)
        let decoder = decoders[T.identifier]
        return try decode(data, using: { decoder?($0) as? T })
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

    // MARK: - Helpers

    private func value(forKey key: Key) throws -> String {
        guard let data = dictionary[key.stringValue] else {
            throw CSVCodingError.keyNotFound(key)
        }
        return data
    }

    private func decode<C: Decodable>(_ string: String, using decoder: @escaping (String) -> C?) throws -> C {
        let decode = decoders[C.identifier] ?? decoder
        guard let value = decode(string) as? C else {
            throw CSVCodingError.couldNotDecode(string, as: C.self)
        }
        return value
    }

    private func decode<C: Decodable>(using generate: @escaping (String) -> C?, forKey key: Key) throws -> C {
        return try decode(try value(forKey: key), using: generate)
    }
}

// MARK: - Extension: KeyedEncodingContainerProtocol

extension CSVKeyedContainer: KeyedEncodingContainerProtocol {

    func encodeNil(forKey key: Key) throws {
        try encode(String?.none, using: { _ in "" }, forKey: key)
    }

    func encode(_ value: Bool, forKey key: Key) throws {
        try encode(value, using: String.init, forKey: key)
    }

    func encode(_ value: String, forKey key: Key) throws {
        try encode(value, using: String.init, forKey: key)
    }

    func encode(_ value: Double, forKey key: Key) throws {
        try encode(value, using: { String($0) }, forKey: key)
    }

    func encode(_ value: Float, forKey key: Key) throws {
        try encode(value, using: { String($0) }, forKey: key)
    }

    func encode(_ value: Int, forKey key: Key) throws {
        try encode(value, using: String.init, forKey: key)
    }

    func encode(_ value: Int8, forKey key: Key) throws {
        try encode(value, using: String.init, forKey: key)
    }

    func encode(_ value: Int16, forKey key: Key) throws {
        try encode(value, using: String.init, forKey: key)
    }

    func encode(_ value: Int32, forKey key: Key) throws {
        try encode(value, using: String.init, forKey: key)
    }

    func encode(_ value: Int64, forKey key: Key) throws {
        try encode(value, using: String.init, forKey: key)
    }

    func encode(_ value: UInt, forKey key: Key) throws {
        try encode(value, using: String.init, forKey: key)
    }

    func encode(_ value: UInt8, forKey key: Key) throws {
        try encode(value, using: String.init, forKey: key)
    }

    func encode(_ value: UInt16, forKey key: Key) throws {
        try encode(value, using: String.init, forKey: key)
    }

    func encode(_ value: UInt32, forKey key: Key) throws {
        try encode(value, using: String.init, forKey: key)
    }

    func encode(_ value: UInt64, forKey key: Key) throws {
        try encode(value, using: String.init, forKey: key)
    }

    func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        try encode(value, using: { _ in nil }, forKey: key)
    }

    func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> {
        return KeyedEncodingContainer(CSVKeyedContainer<NestedKey>())
    }

    func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        assertionFailure(CSVCodingError.nestingNotSupported.description)
        return CSVUnkeyedEncodingContainer()
    }

    func superEncoder() -> Encoder {
        assertionFailure(CSVCodingError.nestingNotSupported.description)
        return CSVObjectEncoder(encoders: encoders)
    }

    func superEncoder(forKey key: Key) -> Encoder {
        assertionFailure(CSVCodingError.nestingNotSupported.description)
        return CSVObjectEncoder(encoders: encoders)
    }

    // MARK: - Helpers

    private func encode<C: Encodable>(_ value: C, using encoder: @escaping (C) -> String?, forKey key: Key) throws {

        let encode = encoders[C.identifier] ?? encoder
        guard let encoded = encode(value) else {
            throw CSVCodingError.couldNotEncode(C.self)
        }
        dictionary[key.stringValue] = encoded
    }

}
