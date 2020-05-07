//
//  UIColor.swift
//  my-paint-shop
//
//  Created by Hadi Albinsaad on 09/04/2019.
//  Copyright © 2019 Hadi. All rights reserved.
//

import UIKit


extension UIColor {
    static var primary = UIColor(hex: 0x121A2E)
    static var secondary = UIColor(hex: 0x272E40)
    static var redx = UIColor(hex: 0xFF453A)
    static var greenx = UIColor(hex: 0x33C3CC)
    static var bluex = UIColor(hex: 0x5C91D4)
    static var orangex = UIColor(hex: 0xFFA325)
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}

