//
//  ErrorPresenter.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation
import UIKit

/// `ErrorPresenter` will help us to describe the behavior of compliant objects to show error alert.
public protocol ErrorPresenter {
	
	/// Show error in an `UIAlertController`.
	func showError(completion: @escaping () -> Void)
}

/// `ErrorPresenter` auto implementation.
public extension ErrorPresenter where Self: UIViewController {
	
	func showError(completion: @escaping () -> Void) {
		DispatchQueue.main.async {
			let alert = UIAlertController(title: "error_title".translate(), message: "error_generic_message".translate(), preferredStyle: UIAlertController.Style.alert)
			
			alert.addAction(UIAlertAction(title: "error_retry".translate(), style: UIAlertAction.Style.destructive, handler: { _ in
				completion()
			}))
			
			self.present(alert, animated: true, completion: nil)
		}
	}
}
