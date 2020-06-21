//
//  Encoder.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

public struct CSVEncoder {

    // MARK: Stored Properties

    public var configuration: CSVConfiguration

    // MARK: Initialization

    public init(configuration: CSVConfiguration = .init()) {
        self.configuration = configuration
    }

}

// MARK: - Configuration

extension CSVEncoder {

    public var delimiter: CSVDelimiter {
        get { configuration.delimiter }
        set { configuration.delimiter = newValue }
    }

    public var enclosure: CSVEnclosure {
        get { configuration.enclosure }
        set { configuration.enclosure = newValue }
    }

    public var encoding: String.Encoding {
        get { configuration.encoding }
        set { configuration.encoding = newValue }
    }

    public var nesting: CSVNesting {
        get { configuration.nesting }
        set { configuration.nesting = newValue }
    }

    public var none: CSVNone {
        get { configuration.none }
        set { configuration.none = newValue }
    }

    public var separator: CSVSeparator {
        get { configuration.separator }
        set { configuration.separator = newValue }
    }

    public var sorting: (String, String) -> Bool {
        get { configuration.sorting }
        set { configuration.sorting = newValue }
    }

    public var unkeying: CSVUnkeying {
        get { configuration.unkeying }
        set { configuration.unkeying = newValue }
    }

    public mutating func register<C: Encodable>(for _: C.Type = C.self, _ encoder: @escaping Encode<C>) {
        configuration.encode(using: encoder)
    }

}

// MARK: - Encoding

extension CSVEncoder {

    public func encodeString<C: Codable>(_ objects: [C]) throws -> String {
        let encoders = try objects.map { object -> EncodingStorage in
            let storage = EncodingStorage(configuration: configuration)
            let encoder = SingleValueEncoder(storage: storage, codingPath: [])
            try object.encode(to: encoder)
            return storage
        }

        let headers = encoders
            .reduce(Set<String>()) { $0.union($1.dictionary.keys) }
            .sorted(by: configuration.sorting)

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

    public func encode<C: Codable>(_ objects: [C]) throws -> Data {
        guard let data = try encodeString(objects).data(using: encoding) else {
            throw CSVCodingError.incorrectEncoding(encoding)
        }
        return data
    }

}
