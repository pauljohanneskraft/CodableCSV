//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

import Foundation

private struct IntegerKey: CodingKey {

    // MARK: Stored Properties

    let value: Int

    // MARK: Initialization

    var intValue: Int? {
        value
    }

    var stringValue: String {
        value.description
    }

    // MARK: Initialization

    init?(intValue: Int) {
        self.value = intValue
    }

    init?(stringValue: String) {
        guard let integer = Int(stringValue) else {
            return nil
        }
        self.value = integer
    }

    init(value: Int) {
        self.value = value
    }

}

extension CSVUnkeying {

    public static let integer = CSVUnkeying(keyForIndex: IntegerKey.init)

}
