//
//  Shape.swift
//  my-paint-shop
//
//  Created by Hadi Albinsaad on 07/04/2019.
//  Copyright © 2019 Hadi. All rights reserved.
//

import UIKit


protocol ShapeDelegate {
    func touchesEnded()
    func touchesBegan(for shape: Shape)
}

class Shape: UIView {
    
    var isSelected = false {
        willSet {
            selectingIndicator.backgroundColor = newValue ? .bluex : .clear
        }
    }
    
    private var initTransform: CGAffineTransform!
    private let delegate: ShapeDelegate
    private var initialTransform: CGAffineTransform?
    private var gestures = Set<UIGestureRecognizer>(minimumCapacity: 3)
    
    private lazy var selectingIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    init(_ delegate: ShapeDelegate, frame: CGRect) {
        self.delegate = delegate
        super.init(frame: frame)
     
        clipsToBounds = true
        cornerRadius = 0
        borderWidth = 0
        borderColor = .clear
        
        backgroundColor = .red
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(processTransform)))
        addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(processTransform)))
        addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(processTransform)))
        
        selectingIndicator.anchor(superview: self, top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, padding: (-15, 5, -5, -5), size: (0, 3))
        
        initTransform = transform
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = true
        delegate.touchesBegan(for: self)
    }
    
    func resetTransform() {
        transform = initTransform
    }
    
    @objc func processTransform(_ sender: Any) {
        
        let gesture = sender as! UIGestureRecognizer
        
        switch gesture.state {
            
        case .began:
            isSelected = true
            if gestures.count == 0 {
                initialTransform = self.transform
            }
            gestures.insert(gesture)
            
        case .changed:
            if var initial = initialTransform {
                gestures.forEach({ (gesture) in
                    initial = transformUsingRecognizer(gesture, transform: initial)
                })
                self.transform = initial
            }
            
        case .ended:
            gestures.remove(gesture)
            
        default:
            break
        }
    }
}

extension Shape: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func transformUsingRecognizer(_ recognizer: UIGestureRecognizer, transform: CGAffineTransform) -> CGAffineTransform {
        
        if let rotateRecognizer = recognizer as? UIRotationGestureRecognizer {
            return transform.rotated(by: rotateRecognizer.rotation)
        }
        
        if let pinchRecognizer = recognizer as? UIPinchGestureRecognizer {
            let scale = pinchRecognizer.scale
            return transform.scaledBy(x: scale, y: scale)
        }
        
        if let panRecognizer = recognizer as? UIPanGestureRecognizer {
            let deltaX = panRecognizer.translation(in: self).x
            let deltaY = panRecognizer.translation(in: self).y
            return transform.translatedBy(x: deltaX, y: deltaY)
        }
        
        return transform
    }
}
