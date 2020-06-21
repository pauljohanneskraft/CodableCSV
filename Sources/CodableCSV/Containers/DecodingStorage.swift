//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

import Foundation

final class DecodingStorage {

    // MARK: Stored Properties

    var userInfo: [CodingUserInfoKey: Any]

    private let dictionary: [String: String]
    private let configuration: CSVConfiguration

    // MARK: Computed Properties

    private var decoders: Decoders {
        configuration.decoders
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

    init(dictionary: [String: String], configuration: CSVConfiguration) {
        self.dictionary = dictionary
        self.configuration = configuration
        self.userInfo = [:]
    }

    // MARK: Methods

    func get(codingPath: [CodingKey]) throws -> String {
        guard let value = dictionary[nesting.nest(codingPath: codingPath)] else {
            throw CSVCodingError.pathNotFound(codingPath)
        }
        return value
    }

    func isNil(codingPath: [CodingKey]) throws -> Bool {
        try none.decodeNil(get(codingPath: codingPath), codingPath: codingPath)
    }

    func isAtEnd(codingPath: [CodingKey]) -> Bool {
        let key = nesting.nest(codingPath: codingPath)
        if let value = dictionary[key] {
            return (try? none.decodeNil(value, codingPath: codingPath)) ?? true
        }
        return !dictionary.keys.contains(where: { $0.hasPrefix(key) })
    }

    func key(index: Int) throws -> CodingKey {
        try unkeying.key(forIndex: index)
    }

    func allKeys<Key: CodingKey>(for type: Key.Type = Key.self, codingPath: [CodingKey]) -> [Key] {
        dictionary.keys
        .compactMap { nesting.key(codingPath: codingPath, for: $0) }
    }

    func decoder<T: Decodable>(for type: T.Type = T.self) -> Decode<T>? {
        decoders[T.identifier].map { decoder in { string in try decoder(string) as! T } }
    }

}
