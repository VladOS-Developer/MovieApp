//
//  CellLabel.swift
//  MovieApp
//
//  Created by VladOS on 12.08.2025.
//

import UIKit

class CellLabel: UILabel {
    
    init(font: UIFont, color: UIColor) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        self.font = font
        self.textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
