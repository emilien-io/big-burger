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
		self.initialViewController = HomeViewController()
		
		guard let initialVC = initialViewController else {
			fatalError("[Main Coordinator - `start()`] Failed to set initial view controller.")
		}
		
		self.navigationController.viewControllers = [initialVC]
	}
	
	func showBurgerDetails() {}
	
}
