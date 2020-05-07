//
//  Canvas.swift
//  my-paint-shop
//
//  Created by Hadi Albinsaad on 28/03/2019.
//  Copyright © 2019 Hadi. All rights reserved.
//

import UIKit


protocol CanvasDelegate {
    func didSelectShape()
    func didDeselectShape()
}

class Canvas: UIView {
    
    private let delegate: CanvasDelegate
    private var shapes = [Shape]()
    private var lines = [Line]()
    private var strokeColor = UIColor.black
    private var strokeWidth: Float = 1
    
    var selectedShape: Shape? {
        return shapes.filter({$0.isSelected}).first
    }
    
    init(_ delegate: CanvasDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        backgroundColor = .clear
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for shape in shapes {
            guard let point = touches.first?.location(in: shape),
                point.x >= 0, point.y >= 0,
                point.x <= shape.frame.width, point.y <= shape.frame.height
                else {
                    shape.isSelected = false
                    delegate.didDeselectShape()
                    continue
            }
            shape.isSelected = true
            delegate.didSelectShape()
            break
        }
        
        if (selectedShape == nil) {
            lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
        }
    } 
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (selectedShape == nil) {
            guard let point = touches.first?.location(in: self) else { return }
            guard var lastLine = lines.popLast() else { return }
            lastLine.points.append(point)
            lines.append(lastLine)
            setNeedsDisplay()
        }
    }
    
    func deselectAllShapes(but shape: Shape) {
        shapes.forEach { (thisShape) in
            thisShape.isSelected = (thisShape === shape)
        }
    }
    
    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }
    
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func deleteSelectedShape() {
        selectedShape?.removeFromSuperview()
        shapes.removeAll(where: {$0 === selectedShape})
    }
    
    func deleteAllShapes() {
        shapes.forEach { (shape) in
            shape.removeFromSuperview()
        }
        shapes = []
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func addShape(_ shape: Shape) {
        shapes.append(shape)
        add(shape)
    }
    
}
