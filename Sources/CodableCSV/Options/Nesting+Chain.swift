//
//  File.swift
//  
//
//  Created by Paul Kraft on 19.06.20.
//

import Foundation

private struct ChainStrategy: NestingStrategy {

    let separator: Character

    func nest(codingPath: [CodingKey]) -> String {
        codingPath
            .map { $0.intValue?.description ?? $0.stringValue }
            .joined(separator: String(separator))
    }

    func key<Key: CodingKey>(codingPath: [CodingKey], for string: String) -> Key? {
        let keys = string.split(separator: separator)
        guard keys.count > codingPath.count else { return nil }
        let key = keys[codingPath.count]
        return Int(key).flatMap(Key.init(intValue:)) ?? Key(stringValue: String(key))
    }

}

extension CSVNesting {

    public static func chain(separator: Character) -> CSVNesting {
        CSVNesting(strategy: ChainStrategy(separator: separator))
    }

}
