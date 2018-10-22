//
//  CSVContainer.swift
//  CodableCSV
//
//  Created by Paul Kraft on 18.08.18.
//  Copyright © 2018 Paul Kraft. All rights reserved.
//

import Foundation

protocol CSVContainer {
    var codingPath: [CodingKey] { get }
    var dictionary: [String: String] { get }
    var decoders: DecoderDictionary { get }
    var encoders: EncoderDictionary { get }
}

extension CSVKeyedContainer: CSVContainer {}
