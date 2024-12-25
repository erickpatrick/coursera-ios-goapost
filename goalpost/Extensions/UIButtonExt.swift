//
//  UIButtonExt.swift
//  goalpost
//
//  Created by Erick Rocha on 25.12.24.
//

import UIKit

extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = .systemGreen
    }
    
    func setDeselectedColor() {
        self.backgroundColor = .systemGreen.withAlphaComponent(0.5)
    }
}
