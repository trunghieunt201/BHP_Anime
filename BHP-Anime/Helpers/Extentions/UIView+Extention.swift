//
//  UIView+Extention.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/6/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
