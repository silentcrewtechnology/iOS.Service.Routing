//
//  Extension+UINavigationViewController.swift
//

import UIKit

extension UINavigationController {
	
	func setRightLeftButton(
		rightBarButtonItem: UIBarButtonItem?,
		leftBarButtonItem: UIBarButtonItem?
	) {
		self.navigationBar.backItem?.leftBarButtonItem = leftBarButtonItem
		self.navigationBar.backItem?.rightBarButtonItem = rightBarButtonItem
	}
	
	func setColor(
		tintColor: UIColor,
		backgroundColor: UIColor
	) {
		self.navigationBar.backgroundColor = backgroundColor
		self.navigationBar.tintColor = tintColor
	}
	
	func setTitle(
		title: String
	) {
		self.title = title
	}
	
	func setBackButtonTitle(title: String) {
		self.navigationBar.backItem?.title = title
		self.navigationItem.backBarButtonItem = .init(
			title: title,
			style: .plain,
			target: nil,
			action: nil
		)
	}
    
    func setBackButtonTintColor(
        tintColor: UIColor = .clear
    ) {
        navigationItem.backBarButtonItem?.tintColor = tintColor
        navigationBar.tintColor = tintColor
    }
    
    func hiddenBackButton() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem = .init(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.backButtonTitle = nil
        navigationItem.backBarButtonItem?.tintColor = .clear
        navigationBar.tintColor = .clear
    }
	
	func setHidden(
		isNavigationBarHidden: Bool,
		animatedHidden: Bool
	) {
		self.navigationBar.isTranslucent = true
		self.navigationBar.shadowImage = UIImage()
		self.setNavigationBarHidden(isNavigationBarHidden, animated: animatedHidden)
	}
}
