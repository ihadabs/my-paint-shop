//
//  ShapePropertiesController.swift
//  my-paint-shop
//
//  Created by Hadi Albinsaad on 18/04/2019.
//  Copyright © 2019 Hadi. All rights reserved.
//

import UIKit


class ShapePropertiesController: UIViewController {
    
    var shape: Shape!
    
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var shapeWidthLabel: UILabel!
    @IBOutlet weak var shapeHeightLabel: UILabel!
    @IBOutlet weak var borderWidthLabel: UILabel!
    @IBOutlet weak var cornerRadiusLabel: UILabel!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shape.resetTransform()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        widthConstraint.constant = shape.frame.width
        heightConstraint.constant = shape.frame.height
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.testView.borderWidth = self.shape.borderWidth
            self.testView.borderColor = self.shape.borderColor
            self.testView.cornerRadius = self.shape.cornerRadius
            self.testView.backgroundColor = self.shape.backgroundColor
        }
        
        updateDimensions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        shape.frame.size.width = widthConstraint.constant
        shape.frame.size.height = heightConstraint.constant
        shape.borderWidth = testView.borderWidth
        shape.borderColor = testView.borderColor
        shape.cornerRadius = testView.cornerRadius
        shape.backgroundColor = testView.backgroundColor
    }
    
    private func updateDimensions() {
        shapeWidthLabel.text = "\(Int(testView.frame.width))"
        shapeHeightLabel.text = "\(Int(testView.frame.height))"
        borderWidthLabel.text = "\(Int(testView.layer.borderWidth))"
        cornerRadiusLabel.text = "\(Int(testView.layer.cornerRadius))"
    }
    
    @IBAction func changeShapeWidth(_ sender: UIButton) {
        if sender.tag == 0 {
            if testView.frame.width <= 20 {
                return
            }
            
            widthConstraint.constant -= 10
            
        } else {
            if testView.frame.width >= 420 {
                return
            }
            
            widthConstraint.constant += 10
        }
        updateDimensions()
    }
    
    @IBAction func changeShapeHeight(_ sender: UIButton) {
        if sender.tag == 0 {
            if testView.frame.height <= 20 {
                return
            }
            
            heightConstraint.constant -= 10
        
        } else {
            if testView.frame.height >= 420 {
                return
            }
            
            heightConstraint.constant += 10
        }
        updateDimensions()
    }
    
    @IBAction func changeShapeColor(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            testView.backgroundColor = .black
        case 1:
            testView.backgroundColor = .red
        case 2:
            testView.backgroundColor = .yellow
        case 3:
            testView.backgroundColor = .blue
        default:
            return
        }
    }
    
    @IBAction func chageCornerRadius(_ sender: UIButton) {
        if sender.tag == 0 {
            if testView.cornerRadius <= 3 {
                return
            }
            
            testView.cornerRadius -= 3
            
        } else {
            
            testView.cornerRadius += 3
        }
        updateDimensions()
    }
    
    @IBAction func changeBorderWidth(_ sender: UIButton) {
        if sender.tag == 0 {
            if testView.borderWidth <= 3 {
                return
            }
            
            testView.borderWidth -= 3
            
        } else {
            
            testView.borderWidth += 3
        }
        updateDimensions()
    }
    
    @IBAction func changeBorderColor(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            testView.borderColor = .black
        case 1:
            testView.borderColor = .red
        case 2:
            testView.borderColor = .yellow
        case 3:
            testView.borderColor = .blue
        default:
            return
        }
    }
}
