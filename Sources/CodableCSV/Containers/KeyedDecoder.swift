//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

struct KeyedDecoder<Key: CodingKey>: DecodingContainer {

    let storage: DecodingStorage
    let codingPath: [CodingKey]

}

// MARK: - KeyedDecodingContainerProtocol

extension KeyedDecoder: KeyedDecodingContainerProtocol {

    // MARK: Computed Properties

    var allKeys: [Key] {
        storage.allKeys(codingPath: codingPath)
    }

    // MARK: Methods - Decoding

    func contains(_ key: Key) -> Bool {
        allKeys.contains(where: { $0.stringValue == key.stringValue })
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        let decoder = SingleValueDecoder(storage: storage, codingPath: codingPath + [key])
        return decoder.decodeNil()
    }

    func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
        if let decode = storage.decoder(for: T.self) {
            return try decode(storage.get(codingPath: codingPath + [key]))
        }
        let decoder = SingleValueDecoder(storage: storage, codingPath: codingPath + [key])
        return try decoder.decode(T.self)
    }

    // MARK: Methods - Containers

    func nestedContainer<NestedKey: CodingKey>(keyedBy type: NestedKey.Type,
                                               forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> {

        let decoder = KeyedDecoder<NestedKey>(storage: storage, codingPath: codingPath + [key])
        return KeyedDecodingContainer(decoder)
    }

    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        UnkeyedDecoder(storage: storage, codingPath: codingPath + [key])
    }

    // MARK: Methods - Decoders

    func superDecoder() throws -> Decoder {
        KeyedDecoder(storage: storage, codingPath: codingPath)
    }

    func superDecoder(forKey key: Key) throws -> Decoder {
        KeyedDecoder(storage: storage, codingPath: codingPath + [key])
    }

}
