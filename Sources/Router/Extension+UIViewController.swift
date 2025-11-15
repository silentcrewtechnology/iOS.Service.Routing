//
//  extension UIViewController.swift
//  
//

import UIKit

public extension UIViewController {
    
    func present(
        with viewController: UIViewController,
        with animated: Bool,
        with transitionStyle: UIModalTransitionStyle,
        with presentationStyle:  UIModalPresentationStyle,
        completion: (() -> Void)? = nil
    ) {
        viewController.modalTransitionStyle   = transitionStyle
        viewController.modalPresentationStyle = presentationStyle
        self.present(
            viewController,
            animated: animated,
            completion: completion
        )
    }
}
