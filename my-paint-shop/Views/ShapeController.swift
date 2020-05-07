//
//  ShapeController.swift
//  my-paint-shop
//
//  Created by Hadi Albinsaad on 13/04/2019.
//  Copyright © 2019 Hadi. All rights reserved.
//

import UIKit


protocol ShapeControllerDelegate {
    func didSelectColorForShape(_ color: UIColor)
    func didDeleteShape()
    func didDeleteAllShapes()
    func didEditShape()
}

class ShapeController: UIStackView {
    
    private let delegate: ShapeControllerDelegate
    
    private let editShapeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Shape", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(editShape), for: .touchUpInside)
        return button
    }()
    
    private let deleteShapeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete Shape", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(deleteShape), for: .touchUpInside)
        return button
    }()
    
    private let deleteAllShapesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete All Shapes", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(deleteAllShapes), for: .touchUpInside)
        return button
    }()
    
    private var blackButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.layer.borderWidth = 1.5
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    private var yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    private var redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    private var blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    private lazy var colorsStackView = UIStackView(arrangedSubviews: [blackButton, redButton, yellowButton, blueButton])
    
    init(_ delegate: ShapeControllerDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        let actionsStackView = UIStackView(arrangedSubviews: [editShapeButton, deleteShapeButton, deleteAllShapesButton])
        actionsStackView.distribution = .fillEqually
        
        colorsStackView.distribution = .fillEqually
        
        addArranged(actionsStackView, colorsStackView)
        
        spacing = 40
        distribution = .fillEqually
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func editShape() {
        delegate.didEditShape()
    }
    
    @objc private func deleteShape() {
        delegate.didDeleteShape()
    }
    
    @objc private func deleteAllShapes() {
        delegate.didDeleteAllShapes()
    }
    
    @objc private func handleColorChange(button: UIButton) {
        delegate.didSelectColorForShape(button.backgroundColor ?? .black)
    }
    
    func configureUI(isHidden: Bool) {
        if isHidden {
            if self.isHidden {return}
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }) { (_) in
                self.isHidden = true
            }
        } else {
            self.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
            }
        }
    }
    
}
