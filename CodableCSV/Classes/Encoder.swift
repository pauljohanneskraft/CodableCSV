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

        guard let keys = encoders.first?.codingPath
            .map({ $0.stringValue })
            .joined(separator: separatorSymbol.stringValue) else {
                return Data()
        }

        let values = encoders
            .map { $0.dictionary.values.joined(separator: separatorSymbol.stringValue) }
            .joined(separator: separatorSymbol.stringValue + "\n") + separatorSymbol.stringValue

        return (keys + separatorSymbol.stringValue + "\n" + values).data(using: .utf8)!
    }
}
