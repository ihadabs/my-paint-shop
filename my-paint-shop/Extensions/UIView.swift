//
//  UIView.swift
//  my-paint-shop
//
//  Created by Hadi Albinsaad on 07/04/2019.
//  Copyright © 2019 Hadi. All rights reserved.
//

import UIKit


extension UIView {
    
    func center(with size: (width:CGFloat,height:CGFloat) = (0,0), to view:UIView? = nil) {
        centerX(to: view)
        centerY(to: view)
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerX(to view:UIView? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let view = view {
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        } else if let superview =  superview {
            centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        }
    }
    
    func centerY(to view:UIView? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let view = view {
            centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else if let superview =  superview {
            centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leadingAnchor
        }
        return leadingAnchor
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.trailingAnchor
        }
        return trailingAnchor
    }
    
    func fillSuperview(padding: (top:CGFloat,left:CGFloat,bottom:CGFloat,right:CGFloat) = (0, 0, 0, 0)) {
        anchor(top: superview?.topAnchor, left: superview?.leadingAnchor, bottom: superview?.bottomAnchor, right: superview?.trailingAnchor, padding: padding)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchorSize(_ size: (width:CGFloat, height:CGFloat)) {
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
    
    func add(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    func anchor(superview: UIView, top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, padding: (top:CGFloat,left:CGFloat,bottom:CGFloat,right:CGFloat) = (0,0,0,0), size: (width:CGFloat,height:CGFloat) = (0,0)) {
        superview.add(self)
        anchor(top: top, left: left, bottom: bottom, right: right, padding: padding, size: size)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, padding: (top:CGFloat,left:CGFloat,bottom:CGFloat,right:CGFloat) = (0,0,0,0), size: (width:CGFloat,height:CGFloat) = (0,0)) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
}


extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
