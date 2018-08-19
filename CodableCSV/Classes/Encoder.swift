//
//  Encoder.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

open class CSVEncoder {
    open var encoding = String.Encoding.utf8
    open var separatorSymbol = CSVSeparatorSymbol.comma

    public init() {}

    open func encodeString<C: Codable>(_ objects: [C]) throws -> String {
        let encoders = try objects.map { object -> CSVObjectEncoder in
            let encoder = CSVObjectEncoder()
            try object.encode(to: encoder)
            return encoder
        }

        guard let headerTitles = encoders.first?.codingPath
            .map({ $0.stringValue })
            .sorted() else {
                return String()
        }

        let keys = headerTitles.joined(separator: separatorSymbol.stringValue)

        let values = encoders
            .map { value in
                headerTitles
                    .map { value.dictionary[$0] ?? "" }
                    .joined(separator: separatorSymbol.stringValue)
            }
            .joined(separator: "\n")

        return keys + "\n" + values
    }

    open func encode<C: Codable>(_ objects: [C]) throws -> Data {
        guard let data = try encodeString(objects).data(using: encoding) else {
            throw CSVCodingError.wrongEncoding(encoding)
        }
        return data
    }
}
