//
//  UIViewExtension.swift
//  MovieApp
//
//  Created by VladOS on 31.07.2025.
//

import UIKit

extension UIView {
    
    func applyGradient(topColor: UIColor, bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = bounds
        gradientLayer.name = "gradientLayer"
        
        layer.sublayers?.removeAll(where: { $0.name == "gradientLayer"})
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
