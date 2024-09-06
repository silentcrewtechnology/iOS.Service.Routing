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
	
	func setBackButton(
		backButtonTitle: String
	) {
		self.navigationBar.backItem?.title = backButtonTitle
		self.navigationItem.backBarButtonItem = .init(
			title: backButtonTitle,
			style: .plain,
			target: nil,
			action: nil
		)
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
