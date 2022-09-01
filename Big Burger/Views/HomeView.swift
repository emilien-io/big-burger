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
	}
	
	/// Allows us to bind the datasource and the delegate of the table view.
	func bindTableView(_ completion: @escaping (UITableView) -> Void) {
		guard let tableView = self.tableView else {
			fatalError("[Home View - `bindTableView()`] Failed to initialize table view.")
		}
		
		completion(tableView)
	}
}
