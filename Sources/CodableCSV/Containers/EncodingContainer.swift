//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

import Foundation

protocol EncodingContainer: Encoder {
    var storage: EncodingStorage { get }
    var codingPath: [CodingKey] { get }
}

extension EncodingContainer {

    var userInfo: [CodingUserInfoKey : Any] {
        get { storage.userInfo }
        set { storage.userInfo = newValue }
    }

    func container<Key: CodingKey>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
        let encoder = KeyedEncoder<Key>(storage: storage, codingPath: codingPath)
        return KeyedEncodingContainer(encoder)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        UnkeyedEncoder(storage: storage, codingPath: codingPath)
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        SingleValueEncoder(storage: storage, codingPath: codingPath)
    }

}
