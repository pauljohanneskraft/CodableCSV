//
//  CSVContainer.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

protocol DecodingContainer: Decoder {
    var storage: DecodingStorage { get }
    var codingPath: [CodingKey] { get }
}

extension DecodingContainer {

    var userInfo: [CodingUserInfoKey : Any] {
        get { storage.userInfo }
        set { storage.userInfo = newValue }
    }

    func container<Key: CodingKey>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> {
        KeyedDecodingContainer(KeyedDecoder<Key>(storage: storage, codingPath: codingPath))
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        UnkeyedDecoder(storage: storage, codingPath: codingPath)
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        SingleValueDecoder(storage: storage, codingPath: codingPath)
    }

}
