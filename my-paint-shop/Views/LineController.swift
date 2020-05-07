//
//  LineController.swift
//  my-paint-shop
//
//  Created by Hadi Albinsaad on 09/04/2019.
//  Copyright © 2019 Hadi. All rights reserved.
//

import UIKit


protocol LineControllerDelegate {
    func didClear()
    func didUndo()
    func didSelectColor(_ color: UIColor)
    func didChangeStrokeWidth(to width: Float)
}

class LineController: UIStackView {
    
    private let delegate: LineControllerDelegate
    
    private let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo Drawing", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(undo), for: .touchUpInside)
        return button
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear Drawing", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(clear), for: .touchUpInside)
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
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    private lazy var colorsStackView = UIStackView(arrangedSubviews: [blackButton, redButton, yellowButton, blueButton])
    
    init(_ delegate: LineControllerDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        let actionsStackView = UIStackView(arrangedSubviews: [undoButton, clearButton])
        actionsStackView.distribution = .fillEqually
        
        colorsStackView.distribution = .fillEqually
        
        addArranged(actionsStackView, colorsStackView, slider)
        
        spacing = 40
        distribution = .fillEqually
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func clear() {
        delegate.didClear()
    }
    
    @objc private func undo() {
        delegate.didUndo()
    }
    
    @objc private func handleColorChange(button: UIButton) {
        for btn in colorsStackView.arrangedSubviews {
            btn.layer.borderWidth = 0.8
        }
        button.layer.borderWidth = 4
        
        delegate.didSelectColor(button.backgroundColor ?? .black)
    }
    
    
    @objc private func handleSliderChange() {
        delegate.didChangeStrokeWidth(to: slider.value)
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
