//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

import Foundation

extension CSVSeparator {

    // MARK: Static Functions

    public static func detect(
        from data: Data,
        encoding: String.Encoding = .utf8,
        candidates: [CSVSeparator] = [.comma, .colon],
        delimiter: CSVDelimiter = .default,
        enclosure: CSVEnclosure = .default
    ) -> CSVSeparator? {

        String(data: data, encoding: encoding).flatMap { string in
            detect(
                from: string,
                candidates: candidates,
                delimiter: delimiter,
                enclosure: enclosure
            )
        }
    }

    public static func detect(
        from string: String,
        candidates: [CSVSeparator] = [.comma, .colon],
        delimiter: CSVDelimiter = .default,
        enclosure: CSVEnclosure = .default
    ) -> CSVSeparator? {

        let rows = string.split(separator: delimiter.character, omittingEmptySubsequences: false)
        guard rows.count > 0 else { return nil }
        return candidates.first { $0.isValid(in: rows) }
    }

    // MARK: Methods

    public func isValid(
        in string: String,
        delimiter: CSVDelimiter = .default,
        enclosure: CSVEnclosure = .default
    ) -> Bool {

        let rows = string.split(separator: delimiter.character, omittingEmptySubsequences: false)
        return isValid(in: rows, enclosure: enclosure)
    }

    // MARK: Helpers

    private func isValid(
        in rows: [Substring],
        enclosure: CSVEnclosure = .default
    ) -> Bool {

        guard let firstRow = rows.first,
            let headerColumnCount = try? columnCount(in: firstRow, enclosure: enclosure),
            headerColumnCount > 1 else {
                return false
        }

        for row in rows.dropFirst() {
            guard let rowColumnCount = try? columnCount(in: row, enclosure: enclosure),
                rowColumnCount == headerColumnCount else {
                    return false
            }
        }

        return true

    }

    private func columnCount(in string: Substring, enclosure: CSVEnclosure) throws -> Int {
        try CSVDecoder.split(row: string, separator: self, enclosure: enclosure).count
    }

}
