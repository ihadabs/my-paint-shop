//
//  UIStackView.swift
//  my-paint-shop
//
//  Created by Hadi Albinsaad on 09/04/2019.
//  Copyright © 2019 Hadi. All rights reserved.
//

import UIKit


extension UIStackView {
    
    func addArranged(_ subviews: UIView...) {
        subviews.forEach(addArrangedSubview)
    }

}
