//
//  Cart.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation

class Cart {
	/// Array of tupples that represent the product and the number of that product in cart.
	var products: [(Product, Int)] = []
	
	// MARK: - Public
	
	func add(_ product: Product) {
		if let index = self.getProductIndex(product) {
			self.products[index].1 += 1
		} else {
			self.products.append((product, 1))
		}
	}
	
	// MARK: - Private
	
	private func getProductIndex(_ product: Product) -> Int? {
		self.products.firstIndex(where: { (p, _) in
			p.ref == product.ref
		})
	}
}
