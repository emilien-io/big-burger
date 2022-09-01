//
//  CoordinatorProtocol.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import UIKit

/// Protocol that describes the behavior of our app coordinator.
/// Using a coordinator lets us remove the job of app navigation from our view controllers,
/// helping make them more manageable and more reusable, while also letting us adjust our app's flow whenever we need.
protocol CoordinatorProtocol {
	
	/// Main navigator controller.
	var navigationController: UINavigationController { get set }
	
	/// Initial view controller of the app.
	var initialViewController: HomeViewController? { get set }
	
	/// Initialize and start the coordinator flow.
	func start()
	
	/// Show the details of an ad.
	/// TODO: - Map & pass burger object.
	func showDetails(for product: Product)
}
