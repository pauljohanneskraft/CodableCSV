//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

struct SingleValueEncoder: EncodingContainer {

    let storage: EncodingStorage
    let codingPath: [CodingKey]

}

extension SingleValueEncoder: SingleValueEncodingContainer {

    mutating func encodeNil() throws {
        try storage.setNil(codingPath: codingPath)
    }

    mutating func encode(_ value: Bool) throws {
        try storage.set(String(value), codingPath: codingPath)
    }

    mutating func encode(_ value: String) throws {
        try storage.set(value, codingPath: codingPath)
    }

    mutating func encode(_ value: Double) throws {
        try storage.set(value.description, codingPath: codingPath)
    }

    mutating func encode(_ value: Float) throws {
        try storage.set(value.description, codingPath: codingPath)
    }

    mutating func encode(_ value: Int) throws {
        try storage.set(value.description, codingPath: codingPath)
    }

    mutating func encode(_ value: Int8) throws {
        try storage.set(value.description, codingPath: codingPath)
    }

    mutating func encode(_ value: Int16) throws {
        try storage.set(value.description, codingPath: codingPath)
    }

    mutating func encode(_ value: Int32) throws {
        try storage.set(value.description, codingPath: codingPath)
    }

    mutating func encode(_ value: Int64) throws {
        try storage.set(value.description, codingPath: codingPath)
    }

    mutating func encode(_ value: UInt) throws {
        try storage.set(value.description, codingPath: codingPath)
    }

    mutating func encode(_ value: UInt8) throws {
        try storage.set(value.description, codingPath: codingPath)
    }

    mutating func encode(_ value: UInt16) throws {
        try storage.set(value.description, codingPath: codingPath)
    }

    mutating func encode(_ value: UInt32) throws {
        try storage.set(value.description, codingPath: codingPath)
    }

    mutating func encode(_ value: UInt64) throws {
        try storage.set(value.description, codingPath: codingPath)
    }

    mutating func encode<T: Encodable>(_ value: T) throws {
        if let encode = storage.encoder(for: T.self) {
            try storage.set(encode(value), codingPath: codingPath)
        } else {
            try value.encode(to: self)
        }
    }

}
