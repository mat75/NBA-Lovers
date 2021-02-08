//
//  Colors.swift
//  Yoofit
//
//  Created by mattia mauceri on 7/9/19.
//  Copyright © 2019 Mattia Mauceri. All rights reserved.
//

import Foundation
import UIKit



extension UIColor {
    
    // Setup custom colours we can use throughout the app using hex values
    static let dirtyWhite = UIColor(red: 248, green: 248, blue: 248)
    static let transparentBlack = UIColor(hex: 0x000000, a: 0.5)
    
    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    // Create a UIColor from a hex value (E.g 0x000000)
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}

