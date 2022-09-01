//
//  HomeView.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation
import UIKit

class HomeView: UIView {
	
	// MARK: - UI Elements
	
	private var tableView: UITableView?
	private var cartButton: CartButton?
	
	// MARK: - Setup
	
	/// Bind the datas and setup the view.
	func setupView() {
		self.backgroundColor = Appearance.backgroundColor
		
		// Table view setup
		self.tableView = UITableView(frame: self.bounds)
		self.tableView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.tableView?.backgroundColor = .clear
		self.tableView?.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
		
		self.addSubview(self.tableView!)
		
		// Cart button
		self.cartButton = CartButton(superview: self)
		
		self.addSubview(self.cartButton!)
	}
	
	/// Allows us to bind the datasource and the delegate of the table view.
	func tableViewAction(_ completion: @escaping (UITableView) -> Void) {
		guard let tableView = self.tableView else {
			fatalError("[Home View - `bindTableView()`] Failed to initialize table view.")
		}
		
		completion(tableView)
	}
	
	/// Increasing count of products in cart
	func updateCart() {
		guard let cartButton = self.cartButton else {
			return
		}
		
		cartButton.increase()
	}
}
