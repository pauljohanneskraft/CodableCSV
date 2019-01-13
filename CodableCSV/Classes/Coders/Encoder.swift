//
//  Encoder.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

typealias EncoderDictionary = [String: (Encodable) -> String?]

open class CSVEncoder {

    // MARK: - Stored properties

    open var encoding = String.Encoding.utf8
    open var separator = CSVSeparator.default
    open var delimiter = CSVDelimiter.default
    open var enclosure = CSVEnclosure.default
    open var nesting = CSVNesting.default
    open var sorting: (String, String) -> Bool = { $0 < $1 }

    private var encoders = EncoderDictionary()

    // MARK: - Init

    public init() {}

    // MARK: - Methods

    open func encodeString<C: Codable>(_ objects: [C]) throws -> String {
        let encoders = try objects.map { object -> CSVObjectEncoder in
            let encoder = CSVObjectEncoder(encoders: self.encoders)
            try object.encode(to: encoder)
            return encoder
        }

        guard let headers = encoders.first?.codingPath
            .map({ $0.stringValue })
            .sorted(by: sorting) else {
                return String()
        }

        let keys = headers.joined(separator: separator.stringValue)

        let rows = encoders
            .map { row in
                headers
                    .map { key in row.dictionary[key] ?? "" }
                    .map { value in
                        if value.contains(separator.character) {
                            return String(enclosure.begin) + value + String(enclosure.end)
                        }
                        return value
                    }
                    .joined(separator: separator.stringValue)
            }
            .joined(separator: delimiter.stringValue)

        return keys + delimiter.stringValue + rows
    }

    open func encode<C: Codable>(_ objects: [C]) throws -> Data {
        guard let data = try encodeString(objects).data(using: encoding) else {
            throw CSVCodingError.wrongEncoding(encoding)
        }
        return data
    }

    open func register<C: Encodable>(encoder: @escaping (C) -> String?) {
        encoders[C.identifier] = { encoder($0 as! C) }
    }
}
