//
//  File.swift
//  
//
//  Created by Paul Kraft on 19.06.20.
//

import Foundation

private struct FlattenStrategy: NestingStrategy {

    func nest(codingPath: [CodingKey]) -> String {
        guard let last = codingPath.last else { return "" }
        return last.intValue?.description ?? last.stringValue
    }

    func key<Key: CodingKey>(codingPath: [CodingKey], for string: String) -> Key? {
        Int(string).flatMap(Key.init(intValue:)) ?? Key(stringValue: string)
    }

}

extension CSVNesting {

    public static var flatten: CSVNesting {
        .init(strategy: FlattenStrategy())
    }

}
