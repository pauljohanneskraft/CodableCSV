//
//  Codable+Identifier.swift
//  CodableCSV
//
//  Created by Paul Kraft on 20.08.18.
//

import Foundation

extension Encodable {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

extension Decodable {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
