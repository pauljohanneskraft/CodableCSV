//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

import Foundation

struct SingleValueDecoder: DecodingContainer {

    let storage: DecodingStorage
    let codingPath: [CodingKey]

}

extension SingleValueDecoder: SingleValueDecodingContainer {

    func decodeNil() -> Bool {
        (try? storage.isNil(codingPath: codingPath)) ?? true
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        try decode(using: type.init)
    }

    func decode(_ type: String.Type) throws -> String {
        try storage.get(codingPath: codingPath)
    }

    func decode(_ type: Double.Type) throws -> Double {
        try decode(using: type.init)
    }

    func decode(_ type: Float.Type) throws -> Float {
        try decode(using: type.init)
    }

    func decode(_ type: Int.Type) throws -> Int {
        try decode(using: type.init)
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        try decode(using: type.init)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        try decode(using: type.init)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        try decode(using: type.init)
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        try decode(using: type.init)
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        try decode(using: type.init)
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try decode(using: type.init)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try decode(using: type.init)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try decode(using: type.init)
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try decode(using: type.init)
    }

    func decode<T: Decodable>(_ type: T.Type) throws -> T {
        if let decode = storage.decoder(for: T.self) {
            return try decode(storage.get(codingPath: codingPath))
        } else {
            return try T.init(from: self)
        }
    }

    private func decode<T: Decodable>(using decode: (String) -> T?) throws -> T {
        let string = try storage.get(codingPath: codingPath)
        if let storedDecode = storage.decoder(for: T.self) {
            return try storedDecode(string)
        } else {
            guard let value = decode(string) else {
                throw CSVCodingError.couldNotDecode(string, as: T.self)
            }
            return value
        }
    }

}
