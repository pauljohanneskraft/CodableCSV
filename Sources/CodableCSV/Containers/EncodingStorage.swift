//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

import Foundation

final class EncodingStorage {

    // MARK: Stored Properties

    var userInfo: [CodingUserInfoKey: Any]

    private(set) var dictionary: [String: String]

    private let configuration: CSVConfiguration

    // MARK: Computed Properties

    private var encoders: Encoders {
        configuration.encoders
    }

    private var nesting: NestingStrategy {
        configuration.nesting.strategy
    }

    private var none: NoneStrategy {
        configuration.none.strategy
    }

    private var unkeying: CSVUnkeying {
        configuration.unkeying
    }

    // MARK: Initialization

    init(configuration: CSVConfiguration) {
        self.configuration = configuration
        self.dictionary = [:]
        self.userInfo = [:]
    }

    // MARK: Methods

    func set(_ string: String, codingPath: [CodingKey]) throws {
        let key = nesting.nest(codingPath: codingPath)
        guard dictionary[key] == nil else {
            throw CSVCodingError.alreadyAssigned(key: key)
        }
        dictionary[key] = string
    }

    func setNil(codingPath: [CodingKey]) throws {
        dictionary[nesting.nest(codingPath: codingPath)] = try none.encodeNil(codingPath: codingPath)
    }

    func key(index: Int) throws -> CodingKey {
        try unkeying.key(forIndex: index)
    }

    func encoder<T: Encodable>(for type: T.Type = T.self) -> Encode<T>? {
        encoders[T.identifier]
    }

}
