//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

import Foundation

public typealias Decode<T> = (String) throws -> T
typealias Decoders = [String: Decode<Decodable>]

public typealias Encode<T> = (T) throws -> String
typealias Encoders = [String: Encode<Encodable>]

public struct CSVConfiguration {

    // MARK: Stored Properties

    public var encoding  = String.Encoding.utf8
    public var separator = CSVSeparator.default
    public var delimiter = CSVDelimiter.default
    public var enclosure = CSVEnclosure.default
    public var nesting   = CSVNesting.default
    public var none      = CSVNone.default
    public var unkeying  = CSVUnkeying.default
    public var sorting: (String, String) -> Bool = { $0 < $1 }

    private(set) var encoders = Encoders()
    private(set) var decoders = Decoders()

    // MARK: Initialization

    public init() {}

    // MARK: Methods

    public mutating func decode<C: Decodable>(_: C.Type = C.self, using decoder: @escaping Decode<C>) {
        decoders.updateValue(decoder, forKey: C.identifier)
    }

    public mutating func encode<C: Encodable>(_: C.Type = C.self, using encoder: @escaping Encode<C>) {
        encoders.updateValue({ try encoder($0 as! C) }, forKey: C.identifier)
    }

}
