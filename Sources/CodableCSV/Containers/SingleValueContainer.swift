//
//  SingleValueContainer.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

struct CSVSingleValueContainer {

    // MARK: Stored Properties

    var codingPath: [CodingKey] { return [] }

}

// MARK: - Extension: SingleValueEncodingContainer

extension CSVSingleValueContainer: SingleValueEncodingContainer {

    mutating func encodeNil() throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: Bool) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: String) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: Double) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: Float) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: Int) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: Int8) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: Int16) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: Int32) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: Int64) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: UInt) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: UInt8) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: UInt16) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: UInt32) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode(_ value: UInt64) throws {
        throw CSVCodingError.singleValuesNotSupported
    }

    mutating func encode<T>(_ value: T) throws where T : Encodable {
        throw CSVCodingError.singleValuesNotSupported
    }

}
