//
//  UIViewController.swift
//  my-paint-shop
//
//  Created by Hadi Albinsaad on 17/04/2019.
//  Copyright © 2019 Hadi. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func alertWithMessage(_ message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "okay", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!;
    }
    
    func printh(_ text: String) {
        print(" @ \(self.className) : \(text)")
    }
    
    func printAlert(_ text: String) {
        print(" @\(self.className) : \(text)")
        self.alertWithMessage(text)
    }
    
    func setVC(title: String) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        navigationItem.titleView = titleLabel
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        view.backgroundColor = .white
    }
}
