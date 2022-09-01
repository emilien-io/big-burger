//
//  ActivityIndicatorPresenter.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation
import UIKit

/// `ActivityIndicatorPresenter` will help us to describe the behavior of compliant classes to show and hide loading indicator.
public protocol ActivityIndicatorPresenter {
	
	/// Activity Indicator property.
	var activityIndicator: UIActivityIndicatorView { get }
	
	/// Show activity indicator.
	func showActivityIndicator()
	
	/// Hide activity indicator.
	func hideActivityIndicator()
}

/// `ActivityIndicatorPresenter` auto implementation.
public extension ActivityIndicatorPresenter where Self: UIViewController {
	
	func showActivityIndicator() {
		DispatchQueue.main.async {
			self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
			self.activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
			self.activityIndicator.backgroundColor = .lightGray.withAlphaComponent(0.4)
			self.activityIndicator.layer.cornerRadius = 10
			self.view.addSubview(self.activityIndicator)
			self.activityIndicator.startAnimating()
		}
	}
	
	func hideActivityIndicator() {
		DispatchQueue.main.async {
			self.activityIndicator.stopAnimating()
			self.activityIndicator.removeFromSuperview()
		}
	}
}
