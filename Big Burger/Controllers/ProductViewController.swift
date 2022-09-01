//
//  ProductViewController.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import UIKit

class ProductViewController: UIViewController {
	
	// MARK: - Properties
	
	private var content: ProductView = ProductView()
	private let product: Product
	
	// MARK: - Initialization
	
	init(with product: Product) {
		self.product = product
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Controller lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.content.delegate = self
		self.content.setupView(self.product)
		self.content.addConstraints()
		self.view = self.content
		
		self.getProductThumbnail()
	}
	
	// MARK: - Private
	
	/// Asynchronously fetch product picture.
	private func getProductThumbnail() {
		guard let url = URL(string: self.product.thumbnail) else {
			self.content.setPlaceholderAsProductThumbnail()
			return
		}
		
		HttpClient.shared.fetchImageData(url) { data, response, error in
			guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
				  let imageData = data else {
				return
			}
			
			DispatchQueue.main.async {
				if statusCode != 200 {
					self.content.setPlaceholderAsProductThumbnail()
				} else {
					self.content.setProductThumbnail(image: UIImage(data: imageData))
				}
			}
		}
	}
}

extension ProductViewController: ProductViewDelegate {
	func addToCart() {
		//TODO: - Add product to cart
	}
}
