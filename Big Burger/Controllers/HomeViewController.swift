//
//  HomeViewController.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import UIKit

class HomeViewController: UIViewController {
	
	// MARK: - Properties
	
	private var content: HomeView = HomeView()
	private var products: [Product]?
	private var basket: Basket = Basket()
	
	private var datasTask: Task<Void, Never>?
	
	// MARK: - Overriden Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "home_title".translate()
		
		self.content.setupView()
		self.content.bindTableView { tableView in
			tableView.delegate = self
			tableView.dataSource = self
		}
		
		self.view = self.content
		
		self.process(.start)
	}
	
	// MARK: - Private
	
	private func process(_ action: HomeAction) {
		switch action {
		case .start:
			self.datasTask = Task {
				await self.fetchProducts()
				self.datasTask = nil
			}
		case .showDetails(let _):
			break
		case .showBasket:
			break
		}
	}
	
	/// Asynchronously fetch the products list and format the datas.
	private func fetchProducts() async {
		// TODO: - Show loader
		
		do {
			try await HttpClient.shared.fetchDatas() { result in
				switch result {
				case .success(let data):
					guard let products = data else {
						// TODO: - Display missing data error
						return
					}
					
					dump(products)
					
					self.products = products
					// TODO: - Hide loader
					
				case .failure(let error):
					// TODO: - Display failure error
					print(error)
				}
			}
		} catch {
			// TODO: - Display failure error
		}
	}

}

// MARK: - UI Table View Delegates

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		160
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
	}
}
