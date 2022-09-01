//
//  CartView.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation
import UIKit

class CartView: UIView {
	
	// MARK: - UI Elements
	
	private let viewTitle: UILabel = {
		let label = UILabel()
		label.textColor = (.black | .white)
		label.font = UIFont(name: "AvenirNext-Bold", size: 30)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private var tableView: UITableView?
	
	let pay: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = Appearance.mainColor
		button.clipsToBounds = true
		button.layer.cornerRadius = 10
		button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 16)
		button.setTitle("cart_payment".translate(), for: .normal)
		button.addTarget(nil, action: #selector(payTapped), for: .touchUpInside)
		return button
	}()
	
	// MARK: - Setup
	
	/// Bind the datas and setup the view.
	func setupView() {
		self.backgroundColor = Appearance.backgroundColor
		self.viewTitle.text = "cart_title".translate()
		
		// Table view setup
		self.tableView = UITableView()
		self.tableView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.tableView?.backgroundColor = .clear
		self.tableView?.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
		self.tableView?.translatesAutoresizingMaskIntoConstraints = false
		
		self.addSubview(self.viewTitle)
		self.addSubview(self.tableView!)
		self.addSubview(self.pay)
	}
	
	/// Setup the layout by adding constraints.
	func addConstraints() {
		NSLayoutConstraint.activate([
			self.viewTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
			self.viewTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
			self.viewTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
			self.viewTitle.heightAnchor.constraint(equalToConstant: 40),
			
			self.pay.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
			self.pay.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
			self.pay.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
			self.pay.heightAnchor.constraint(equalToConstant: 50),
		])
		
		if let tableView = self.tableView {
			NSLayoutConstraint.activate([
				tableView.topAnchor.constraint(equalTo: self.viewTitle.bottomAnchor, constant: 20),
				tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
				tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
				tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			])
		}
	}
	
	/// Allows us to bind the datasource and the delegate of the table view.
	func tableViewAction(_ completion: @escaping (UITableView) -> Void) {
		guard let tableView = self.tableView else {
			fatalError("[Home View - `bindTableView()`] Failed to initialize table view.")
		}
		
		completion(tableView)
	}
	
	// MARK: - OBJC Methods
	
	@objc func payTapped() {
		// TODO: - Handle payment here
	}
}
