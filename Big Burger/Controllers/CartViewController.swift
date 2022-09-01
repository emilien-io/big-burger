//
//  CartViewController.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import UIKit

class CartViewController: UIViewController {
	
	// MARK: - Properties
	
	private var content: CartView = CartView()
	private let cart: Cart
	
	// MARK: - Initialization
	
	init(with cart: Cart) {
		self.cart = cart
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Controller lifecycle

    override func viewDidLoad() {
		super.viewDidLoad()
		
		self.content.setupView()
		self.content.addConstraints()
		
		self.content.tableViewAction { tableView in
			tableView.dataSource = self
			tableView.delegate = self
			tableView.reloadData()
		}
		
		self.view = self.content
    }
    
}

// MARK: - UI Table View Delegates

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		140
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.cart.products.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let datas = self.cart.products[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
		
		cell.initializeCell(withProduct: datas.0, occurence: datas.1)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
