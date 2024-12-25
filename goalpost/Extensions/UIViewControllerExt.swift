//
//  UIViewControllerExt.swift
//  goalpost
//
//  Created by Erick Rocha on 25.12.24.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: "CATransition")
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: "CATransition")
        
        dismiss(animated: false, completion: nil)
    }
}
