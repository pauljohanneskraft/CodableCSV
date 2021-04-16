//
//  File.swift
//  
//
//  Created by Paul Kraft on 21.06.20.
//

private struct EmptyStrategy: NoneStrategy {

    func encodeNil(codingPath: [CodingKey]) throws -> String {
        .init()
    }

    func decodeNil(_ string: String, codingPath: [CodingKey]) -> Bool {
        string.isEmpty
    }

}

extension CSVNone {

    public static let empty = CSVNone(strategy: EmptyStrategy())

}
