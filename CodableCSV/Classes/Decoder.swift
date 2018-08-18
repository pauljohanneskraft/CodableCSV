//
//  Decoder.swift
//  SwiftyCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

open class CSVDecoder {
    open var separatorSymbol = CSVSeparatorSymbol.colon
    open var encoding = String.Encoding.utf8

    public init() {}

    open func decode<C: Decodable>(_ type: C.Type, from data: Data) throws -> [C] {
        guard let string = String(data: data, encoding: encoding) else {
            throw CSVCodingError.wrongEncoding(encoding)
        }
        let lines = string.split(separator: "\n")
        guard let header = lines.first else {
            return []
        }
        let headerFields = header.split(separator: separatorSymbol.character).map(String.init)

        return try lines.dropFirst().map { objectString in
            let decoder = CSVObjectDecoder(headerFields: headerFields, string: String(objectString), separatorSymbol: separatorSymbol.character)
            return try C(from: decoder)
        }
    }
}
