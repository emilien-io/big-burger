//
//  MainCoordinator.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
	
	// MARK: - Properties
	
	var navigationController: UINavigationController
	var initialViewController: HomeViewController?
	
	// MARK: - Initialization
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.navigationController.setNavigationBarHidden(false, animated: false)
	}
	
	// MARK: - Public
	
	func start() {
		self.initialViewController = HomeViewController(with: self)
		
		guard let initialVC = initialViewController else {
			fatalError("[Main Coordinator - `start()`] Failed to set initial view controller.")
		}
		
		self.navigationController.viewControllers = [initialVC]
	}
	
	func showDetails(for product: Product, with completion: @escaping (Product) -> ()) {
		let nav = UINavigationController(rootViewController: ProductViewController(for: product, with: completion))
		nav.modalPresentationStyle = .pageSheet
		if let sheet = nav.sheetPresentationController {
			sheet.detents = [.medium()]
		}
		
		guard let currentVC = self.navigationController.viewControllers.last else {
			fatalError("[Main Coordinator - `showDetails()`] Failed to get last view controller in navigation.")
		}
		
		currentVC.present(nav, animated: true)
	}
	
}
