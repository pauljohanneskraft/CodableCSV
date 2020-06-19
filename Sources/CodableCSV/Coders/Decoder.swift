//
//  Decoder.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

typealias DecoderDictionary = [String: (String) -> Decodable?]

open class CSVDecoder {

    // MARK: Stored Properties

    open var encoding = String.Encoding.utf8
    open var separator = CSVSeparator.default
    open var delimiter = CSVDelimiter.default
    open var enclosure = CSVEnclosure.default
    open var nesting = CSVNesting.flatten

    private var decoders = DecoderDictionary()

    // MARK: Initialization

    public init() {}

    // MARK: Methods

    open func decode<C: Decodable>(_ type: C.Type, from data: Data) throws -> [C] {
        guard let string = String(data: data, encoding: encoding) else {
            throw CSVCodingError.wrongEncoding(encoding)
        }
        return try decode(type, from: string)
    }

    open func decode<C: Decodable>(_ type: C.Type, from string: String) throws -> [C] {
        let lines = try string
            .split(separator: delimiter.character)
            .map(split)

        guard let headers = lines.first else {
            return []
        }

        return try lines.dropFirst().map { values in
            let decoder = try CSVObjectDecoder(
                headers: headers,
                values: values,
                decoders: decoders
            )
            return try C(from: decoder)
        }
    }

    open func register<C: Decodable>(decoder: @escaping (String) -> C?) {
        decoders[C.identifier] = decoder
    }

    // MARK: Helpers

    private func split(row: Substring) throws -> [String] {
        return try CSVDecoder.split(row: row, separator: separator, enclosure: enclosure)
    }

    static func split(row: Substring, separator: CSVSeparator, enclosure: CSVEnclosure) throws -> [String] {
        var accumulator = ""
        let result = row
            .split(separator: separator.character, omittingEmptySubsequences: false)
            .map(String.init)
            .compactMap { header -> String? in
                if header.hasSuffix(enclosure.end) && !accumulator.isEmpty {
                    defer { accumulator = "" }
                    return accumulator + header.dropLast(enclosure.end.count)
                }
                guard accumulator.isEmpty else {
                    accumulator = accumulator + header + separator.stringValue
                    return nil
                }
                guard header.hasPrefix(enclosure.begin) else {
                    return header
                }
                if header.hasPrefix(enclosure.begin) {
                    if header.hasSuffix(enclosure.end) {
                        return String(
                            header
                                .dropFirst(enclosure.begin.count)
                                .dropLast(enclosure.end.count)
                        )
                    } else {
                        accumulator = accumulator + header.dropFirst(enclosure.begin.count) + separator.stringValue
                        return nil
                    }
                }
                return header
            }

        guard accumulator.isEmpty else {
            throw CSVCodingError.enclosureConflict
        }
        
        return result
    }

}
