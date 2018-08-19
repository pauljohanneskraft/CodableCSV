//
//  Error.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

enum CSVCodingError: Error {
    case wrongEncoding(String.Encoding)
    case nestingNotSupported
    case singleValuesNotSupported
    case unkeyedNotSupported
    case headerMismatch
    case keyNotFound(CodingKey)
    case couldNotEncode(Encodable.Type)
    case couldNotDecode(String, `as`: Decodable.Type)
}
