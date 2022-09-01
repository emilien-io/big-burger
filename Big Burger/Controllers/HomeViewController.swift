//
//  HomeViewController.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import UIKit

class HomeViewController: UIViewController, ActivityIndicatorPresenter, ErrorPresenter {
	
	// MARK: - Properties
	
	private weak var coordinator: MainCoordinator?
	private var content: HomeView = HomeView()
	
	private var products: [Product]?
	private var cart: Cart = Cart()
	
	private var datasTask: Task<Void, Never>?
	
	var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
	
	// MARK: - Initialization
	
	init(with coordinator: MainCoordinator) {
		self.coordinator = coordinator

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Controller lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "home_title".translate()
		
		self.content.setupView()
		self.content.tableViewAction { tableView in
			tableView.delegate = self
			tableView.dataSource = self
		}
		
		self.view = self.content
		
		self.process(.start)
	}
	
	// MARK: - Private
	
	/// Function that help us to route a specific action.
	/// - Parameters:
	///   - action: Action to perform.
	private func process(_ action: HomeAction) {
		switch action {
		case .start:
			self.datasTask = Task {
				await self.fetchProducts()
				self.datasTask = nil
			}
		case .showDetails(let product):
			self.displayProductDetails(product)
			break
		case .showBasket:
			break
		}
	}
	
	/// Asynchronously fetch the products list and format the datas.
	private func fetchProducts() async {
		self.showActivityIndicator()
		
		do {
			try await HttpClient.shared.fetchDatas() { result in
				switch result {
				case .success(let data):
					guard let products = data else {
						self.handleError(HttpErrors.missingData)
						return
					}
					
					self.reloadTableView(with: products)
				case .failure(let error):
					self.handleError(error)
				}
			}
		} catch {
			self.handleError(nil)
		}
	}
	
	/// Something went wrong and app displays a message, the user can retry to fetch the datas.
	/// - Parameters:
	///   - error: Error thrown.
	private func handleError(_ error: Error?) {
		self.showError {
			self.process(.start)
		}
	}
	
	/// Handles and manage the datas that just been fetched.
	private func reloadTableView(with products: [Product]) {
		self.products = products
		self.hideActivityIndicator()
		
		self.content.tableViewAction { tableView in
			DispatchQueue.main.async {
				tableView.reloadData()
			}
		}
	}
	
	/// Uses the main coordinator to display the product details.
	/// - Parameters:
	///   - product: Product to display.
	private func displayProductDetails(_ product: Product) {
		guard let coordinator = self.coordinator else {
			return
		}
		
		coordinator.showDetails(for: product) { productToAdd in
			self.cart.add(productToAdd)
			self.content.updateCart()
		}
	}

}

// MARK: - UI Table View Delegates

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		140
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.products?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let datas = self.products else {
			fatalError("[Home View Controller] `products` has not been intialized.")
		}
		
		let product: Product = datas[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
		
		cell.initializeCell(withProduct: product)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)

		guard let product = self.products?[indexPath.row] else {
			return
		}

		self.process(.showDetails(product))
	}
}
