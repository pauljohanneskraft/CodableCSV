//
//  Error.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

public enum CSVCodingError: Error {
    case wrongEncoding(String.Encoding)
    case nestingNotSupported
    case singleValuesNotSupported
    case unkeyedNotSupported
    case headerMismatch
    case enclosureConflict
    case keyNotFound(CodingKey)
    case couldNotEncode(Encodable.Type)
    case couldNotDecode(String, `as`: Decodable.Type)
}

extension CSVCodingError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .wrongEncoding(let encoding):
            return "Data is not encoded using \(encoding)."
        case .nestingNotSupported:
            return "CodableCSV does not support nested types."
        case .singleValuesNotSupported:
            return "CodableCSV does not support single values."
        case .unkeyedNotSupported:
            return "CodableCSV does not support unkeyed containers."
        case .headerMismatch:
            return "The header title count did not match the amount of detected values. You might want to change the separator symbol to circumvent problems regarding this issue."
        case .keyNotFound(let key):
            return "Could not find value for key \"\(key)\"."
        case .couldNotEncode(let type):
            return "Could not encode value of type \(type)."
        case .couldNotDecode(let string, let type):
            return "Could not decode \"\(string)\" as \(type)."
        case .enclosureConflict:
            return "Data is not correctly enclosed. You may want to change the enclosure characters of the encoder/decoder."
        }
    }
}
