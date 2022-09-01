//
//  HomeAction.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation

/// Actions that describes a set of flow to execute.
enum HomeAction {
	
	/// Start fetching the datas.
	case start
	
	/// User tapped on a product to see the details.
	/// - Parameters:
	///   - product: Selected product
	case showDetails(_ product: Product)
	
	/// Will display the user basket.
	case showBasket
}
