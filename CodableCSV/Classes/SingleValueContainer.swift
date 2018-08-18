//
//  SingleValueContainer.swift
//  SwiftyCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

struct CSVSingleValueContainer {

    // MARK: - Stored properties

    var codingPath: [CodingKey]
    var data: String
}

// MARK: - Extension: SingleValueEncodingContainer

extension CSVSingleValueContainer: SingleValueEncodingContainer {

    mutating func encodeNil() throws {
        data = "null"
    }

    mutating func encode(_ value: Bool) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: String) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: Double) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: Float) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: Int) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: Int8) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: Int16) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: Int32) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: Int64) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: UInt) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: UInt8) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: UInt16) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: UInt32) throws {
        data = String(describing: value)
    }

    mutating func encode(_ value: UInt64) throws {
        data = String(describing: value)
    }

    mutating func encode<T>(_ value: T) throws where T : Encodable {
        throw CSVCodingError.couldNotEncode(T.self)
    }
}

// MARK: - Extension: SingleValueDecodingContainer

extension CSVSingleValueContainer: SingleValueDecodingContainer {
    func decodeNil() -> Bool {
        return data == "null"
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        guard let value = Bool(data) else {
            throw CSVCodingError.couldNotDecode(data, as: Bool.self)
        }
        return value
    }

    func decode(_ type: String.Type) throws -> String {
        return data
    }

    func decode(_ type: Double.Type) throws -> Double {
        guard let value = Double(data) else {
            throw CSVCodingError.couldNotDecode(data, as: Double.self)
        }
        return value
    }

    func decode(_ type: Float.Type) throws -> Float {
        guard let value = Float(data) else {
            throw CSVCodingError.couldNotDecode(data, as: Float.self)
        }
        return value
    }

    func decode(_ type: Int.Type) throws -> Int {
        guard let value = Int(data) else {
            throw CSVCodingError.couldNotDecode(data, as: Int.self)
        }
        return value
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        guard let value = Int8(data) else {
            throw CSVCodingError.couldNotDecode(data, as: Int8.self)
        }
        return value
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        guard let value = Int16(data) else {
            throw CSVCodingError.couldNotDecode(data, as: Int16.self)
        }
        return value
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        guard let value = Int32(data) else {
            throw CSVCodingError.couldNotDecode(data, as: Int32.self)
        }
        return value
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        guard let value = Int64(data) else {
            throw CSVCodingError.couldNotDecode(data, as: Int64.self)
        }
        return value
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        guard let value = UInt(data) else {
            throw CSVCodingError.couldNotDecode(data, as: UInt.self)
        }
        return value
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        guard let value = UInt8(data) else {
            throw CSVCodingError.couldNotDecode(data, as: UInt8.self)
        }
        return value
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        guard let value = UInt16(data) else {
            throw CSVCodingError.couldNotDecode(data, as: UInt16.self)
        }
        return value
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        guard let value = UInt32(data) else {
            throw CSVCodingError.couldNotDecode(data, as: UInt32.self)
        }
        return value
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        guard let value = UInt64(data) else {
            throw CSVCodingError.couldNotDecode(data, as: UInt64.self)
        }
        return value
    }

    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        throw CSVCodingError.couldNotDecode(data, as: T.self)
    }
}
