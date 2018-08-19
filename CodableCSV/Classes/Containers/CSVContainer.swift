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
}

extension CSVKeyedContainer: CSVContainer {}
