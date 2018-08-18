//
//  Encoder.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

open class CSVEncoder {
    open var separatorSymbol = CSVSeparatorSymbol.colon

    public init() {}

    open func encode<C: Codable>(_ objects: [C]) throws -> Data {
        let encoders = try objects.map { object -> CSVObjectEncoder in
            let encoder = CSVObjectEncoder()
            try object.encode(to: encoder)
            return encoder
        }

        guard let headerTitles = encoders.first?.codingPath
            .map({ $0.stringValue })
            .sorted() else {
                return Data()
        }

        let keys = headerTitles.joined(separator: separatorSymbol.stringValue)

        let values = encoders
            .map { value in
                headerTitles
                    .map { value.dictionary[$0] ?? "" }
                    .joined(separator: separatorSymbol.stringValue)
            }
            .joined(separator: "\n")

        return (keys + separatorSymbol.stringValue + "\n" + values).data(using: .utf8)!
    }
}
