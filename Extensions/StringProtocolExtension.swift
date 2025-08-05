//
//  StringProtocolExtension.swift
//  MovieApp
//
//  Created by VladOS on 04.08.2025.
//

import Foundation

extension StringProtocol {
    var digits: [Int] { compactMap(\.wholeNumberValue) }
}
