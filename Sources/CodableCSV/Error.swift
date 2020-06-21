//
//  Error.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

public enum CSVCodingError: Error {
    case incorrectEncoding(String.Encoding)
    case headerMismatch
    case enclosureConflict
    case pathNotFound([CodingKey])
    case alreadyAssigned(key: String)
    case couldNotEncode(Encodable.Type)
    case couldNotDecode(String, `as`: Decodable.Type)
}

// MARK: - Extension: CustomStringConvertible

extension CSVCodingError: CustomStringConvertible {

    public var description: String {
        switch self {
        case .incorrectEncoding(let encoding):
            return "Data is not encoded using \(encoding)."
        case let .alreadyAssigned(key):
            return "Tried to assign \(key) twice."
        case .headerMismatch:
            return "The header title count did not match the amount of detected values. You might want to change the separator symbol to circumvent problems regarding this issue."
        case .pathNotFound(let codingPath):
            return "Could not find value for codingPath \"\(codingPath)\"."
        case .couldNotEncode(let type):
            return "Could not encode value of type \(type)."
        case .couldNotDecode(let string, let type):
            return "Could not decode \"\(string)\" as \(type)."
        case .enclosureConflict:
            return "Data is not correctly enclosed. You may want to change the enclosure characters of the encoder/decoder."
        }
    }

}
