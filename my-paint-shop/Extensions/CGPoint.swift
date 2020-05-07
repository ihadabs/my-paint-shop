//
//  CGPoint.swift
//  my-paint-shop
//
//  Created by Hadi Albinsaad on 07/04/2019.
//  Copyright © 2019 Hadi. All rights reserved.
//

import UIKit


extension CGPoint {
    
    mutating func plus(_ point: CGPoint) {
        self.x += point.x
        self.y += point.y
    }
}
