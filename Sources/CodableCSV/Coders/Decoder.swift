//
//  Decoder.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

public struct CSVDecoder {

    // MARK: Stored Properties

    public var configuration: CSVConfiguration

    // MARK: Initialization

    public init(configuration: CSVConfiguration = .init()) {
        self.configuration = configuration
    }

}

// MARK: - Computed Properties

extension CSVDecoder {

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
    
    public var unkeying: CSVUnkeying {
        get { configuration.unkeying }
        set { configuration.unkeying = newValue }
    }

    public mutating func register<C: Decodable>(for _: C.Type = C.self, _ decoder: @escaping Decode<C>) {
        configuration.decode(using: decoder)
    }

}

// MARK: - Decoding

extension CSVDecoder {

    public func decode<C: Decodable>(_ type: C.Type = C.self, from data: Data) throws -> [C] {
        guard let string = String(data: data, encoding: encoding) else {
            throw CSVCodingError.incorrectEncoding(encoding)
        }
        return try decode(type, from: string)
    }

    public func decode<C: Decodable>(_ type: C.Type = C.self, from string: String) throws -> [C] {
        let lines = try string
            .split(separator: delimiter.character)
            .map(split)

        guard let headers = lines.first else {
            return []
        }

        return try lines.dropFirst()
            .map { try decodeSingle(headers: headers, values: $0) }
    }

    private func decodeSingle<C: Decodable>(_ type: C.Type = C.self, headers: [String], values: [String]) throws -> C {
        guard headers.count == values.count else {
            throw CSVCodingError.headerMismatch
        }

        var dictionary = [String: String]()
        for i in headers.indices {
            dictionary[headers[i]] = values[i]
        }

        let storage = DecodingStorage(dictionary: dictionary, configuration: configuration)
        let decoder = SingleValueDecoder(storage: storage, codingPath: [])
        return try C(from: decoder)
    }

}

// MARK: - Helpers

extension CSVDecoder {

    static func split(row: Substring, separator: CSVSeparator, enclosure: CSVEnclosure) throws -> [String] {
        var accumulator = ""
        let result = row
            .split(separator: separator.character, omittingEmptySubsequences: false)
            .compactMap { newHeader(in: $0, accumulator: &accumulator, separator: separator, enclosure: enclosure) }

        guard accumulator.isEmpty else {
            throw CSVCodingError.enclosureConflict
        }

        return result
    }

    private func split(row: Substring) throws -> [String] {
        return try CSVDecoder.split(row: row, separator: separator, enclosure: enclosure)
    }

    private static func newHeader(in header: Substring,
                                  accumulator: inout String,
                                  separator: CSVSeparator,
                                  enclosure: CSVEnclosure) -> String? {

        guard accumulator.isEmpty else {

            guard !header.hasSuffix(enclosure.end) else {
                defer { accumulator.removeAll(keepingCapacity: true) }
                return accumulator + header.dropLast(enclosure.end.count)
            }

            accumulator.append(contentsOf: header + separator.stringValue)
            return nil

        }

        guard header.hasPrefix(enclosure.begin) else {
            return String(header)
        }

        let headerWithoutPrefix = header.dropFirst(enclosure.begin.count)

        if headerWithoutPrefix.hasSuffix(enclosure.end) {
            return String(
                headerWithoutPrefix
                    .dropLast(enclosure.end.count)
            )
        }

        accumulator = headerWithoutPrefix + separator.stringValue
        return nil

    }

}
