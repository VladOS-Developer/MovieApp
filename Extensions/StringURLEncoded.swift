//
//  StringURLEncoded.swift
//  MovieApp
//
//  Created by VladOS on 17.11.2025.
//

import Foundation

extension String {
    var urlEncoded: String {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
}
