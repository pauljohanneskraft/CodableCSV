//
//  UnkeyedContainer.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//

import Foundation

final class CSVUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    var codingPath: [CodingKey] {
        return []
    }

    var count: Int {
        return 0
    }

    func encodeNil() throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: Bool) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: String) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: Double) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: Float) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: Int) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: Int8) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: Int16) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: Int32) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: Int64) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: UInt) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: UInt8) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: UInt16) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: UInt32) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode(_ value: UInt64) throws {
        throw CSVCodingError.unkeyedNotSupported
    }

    func encode<T>(_ value: T) throws where T : Encodable {
        throw CSVCodingError.unkeyedNotSupported
    }

    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        assertionFailure("\(CSVCodingError.nestingNotSupported).")
        return KeyedEncodingContainer(CSVKeyedContainer<NestedKey>())
    }

    func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        assertionFailure("\(CSVCodingError.nestingNotSupported).")
        return CSVUnkeyedEncodingContainer()
    }

    func superEncoder() -> Encoder {
        assertionFailure("\(CSVCodingError.nestingNotSupported).")
        return CSVObjectEncoder()
    }
}
