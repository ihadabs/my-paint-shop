//
//  ViewController.swift
//  my-paint-shop
//
//  Created by Hadi Albinsaad on 28/03/2019.
//  Copyright © 2019 Hadi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var canvas = Canvas(self)
    private lazy var lineController = LineController(self)
    private lazy var shapeController = ShapeController(self)
    
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var addBarButton = UIBarButtonItem(title: "Add Shape", style: .plain, target: self, action: #selector(add))
    private lazy var openBarButton = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(open))
    private lazy var deleteOpendImageBarButton = UIBarButtonItem(title: "Delete Opend Image", style: .plain, target: self, action: #selector(deleteOpendImage))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItems = [addBarButton, openBarButton]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        lineController.anchor(superview:view, top: nil, left: view.safeLeftAnchor, bottom: view.safeBottomAnchor, right: view.safeRightAnchor, padding: (0, 30, -16, -30), size: (0, 44))
        
        shapeController.anchor(superview:view, top: nil, left: view.safeLeftAnchor, bottom: view.safeBottomAnchor, right: view.safeRightAnchor, padding: (0, 30, -16, -30), size: (0, 44))
        
        imageView.anchor(superview: view, top: view.safeTopAnchor, left: view.safeLeftAnchor, bottom: lineController.topAnchor, right: view.safeRightAnchor)
        
        canvas.anchor(superview: view, top: view.safeTopAnchor, left: view.safeLeftAnchor, bottom: lineController.topAnchor, right: view.safeRightAnchor)
        
        view.backgroundColor = .white
        view.bringSubviewToFront(canvas)
        
        setShapeController(isHidden: true)
    }
    
    @objc private func open() {
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func deleteOpendImage() {
        imageView.image = nil
        navigationItem.rightBarButtonItems = [addBarButton, openBarButton]
    }
    
    @objc private func share() {
        let activityViewController = UIActivityViewController(activityItems: [generateDrawnImage()], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { (activity, completed, items, error) in
            if completed {
                self.alertWithMessage("✅")
            }
        }
        
        activityViewController.popoverPresentationController?.sourceView = view
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 35, y: 60, width: 0, height: 0)
        present(activityViewController, animated: true, completion: nil)
    }
    
    @objc private func add(sender: UIButton) {
        let canvasCenter = canvas.center
        let length: CGFloat = 250
        let shapeOrigin = CGPoint(x: canvasCenter.x - length/2, y: canvasCenter.y - length/2)
        let shapeSize = CGSize(width: length, height: length)
        let shape = Shape(self, frame: CGRect(origin: shapeOrigin, size: shapeSize))
        canvas.addShape(shape)
        
        self.view.bringSubviewToFront(lineController)
        self.view.bringSubviewToFront(shapeController)
    }
    
    // MARK: Helpers
    
    func generateDrawnImage() -> UIImage {
        
        UIGraphicsBeginImageContext(canvas.frame.size)
        view.drawHierarchy(in: canvas.frame, afterScreenUpdates: true)
        let drawnImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return drawnImage
    }
    
    func setShapeController(isHidden: Bool) {
        shapeController.configureUI(isHidden: isHidden)
        lineController.configureUI(isHidden: !isHidden)
    }

}

extension MainViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        imageView.image = image
        navigationItem.rightBarButtonItems = [addBarButton, deleteOpendImageBarButton]
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension MainViewController: ShapeDelegate {
    func touchesBegan(for shape: Shape) {
        canvas.deselectAllShapes(but: shape)
        canvas.bringSubviewToFront(shape)
        setShapeController(isHidden: false)
    }
    
    func touchesEnded() {
        setShapeController(isHidden: true)
    }
}

extension MainViewController: CanvasDelegate {
    func didDeselectShape() {
        setShapeController(isHidden: true)
    }
    
    func didSelectShape() {
        setShapeController(isHidden: false)
    }
}

extension MainViewController: LineControllerDelegate {
    func didClear() {
        canvas.clear()
    }
    
    func didUndo() {
        canvas.undo()
    }
    
    func didSelectColor(_ color: UIColor) {
        canvas.setStrokeColor(color: color)
    }
    
    func didChangeStrokeWidth(to width: Float) {
        canvas.setStrokeWidth(width: width)
    }
}

extension MainViewController: ShapeControllerDelegate {
    func didEditShape() {
        let shapePropertiesController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShapePropertiesController") as! ShapePropertiesController
        shapePropertiesController.shape = canvas.selectedShape
        navigationController?.pushViewController(shapePropertiesController, animated: true)
    }
    
    func didDeleteShape() {
        canvas.deleteSelectedShape()
        setShapeController(isHidden: true)
    }
    
    func didDeleteAllShapes() {
        canvas.deleteAllShapes()
        setShapeController(isHidden: true)
    }
    
    func didSelectColorForShape(_ color: UIColor) {
        canvas.selectedShape?.backgroundColor = color
    }
}

