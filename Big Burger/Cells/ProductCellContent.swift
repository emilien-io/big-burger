//
//  ProductCellContent.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation
import UIKit

class ProductCellContent: UIView {
	
	// MARK: - UI Properties
	
	let productTitle: UILabel = {
		let label = UILabel()
		label.textColor = .black | .white
		label.font = UIFont(name: "Futura-Medium", size: 14)
		label.numberOfLines = 3
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let productDescription: UILabel = {
		let label = UILabel()
		label.textColor = (.black | .white).withAlphaComponent(0.4)
		label.font = UIFont(name: "AvenirNext-Medium", size: 13)
		label.numberOfLines = 3
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let productPrice: PaddingLabel = {
		let label = PaddingLabel()
		label.textColor = .white
		label.backgroundColor = Appearance.mainColor
		label.paddingTop = 2
		label.paddingLeft = 5
		label.paddingRight = 5
		label.paddingBottom = 2
		label.font = UIFont(name: "AvenirNext-Bold", size: 12)
		label.clipsToBounds = true
		label.layer.cornerRadius = 5
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let productThumb: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = .lightGray.withAlphaComponent(0.7)
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 5
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	// MARK: - Methods
	
	/// Bind the datas and setup the view.
	func setupView(_ product: Product?, _ number: Int? = nil) {
		self.productTitle.text = self.getProductTitle(product, number)
		self.productPrice.text = "\(self.getProductPrice(product, number)) €"
		self.productDescription.text = product?.description ?? "product_unknown_description".translate()
		
		self.addSubview(self.productThumb)
		self.addSubview(self.productTitle)
		self.addSubview(self.productPrice)
		self.addSubview(self.productDescription)
	}
	
	/// Setup the layout by adding constraints.
	func addConstraints() {
		guard let superview = self.superview else {
			fatalError("[Product Cell Content] Failed to get superview.")
		}
		
		self.productThumb.frame = CGRect(x: 10, y: 10, width: 150, height: 120)
		
		NSLayoutConstraint.activate([
			self.productTitle.topAnchor.constraint(equalTo: self.productThumb.topAnchor),
			self.productTitle.leftAnchor.constraint(equalTo: self.productThumb.rightAnchor, constant: 15),
			self.productTitle.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -10),
			self.productTitle.heightAnchor.constraint(equalToConstant: 40),

			self.productPrice.bottomAnchor.constraint(equalTo: self.productThumb.bottomAnchor, constant: -10),
			self.productPrice.rightAnchor.constraint(equalTo: self.productThumb.rightAnchor, constant: -10),
			
			self.productDescription.topAnchor.constraint(equalTo: self.productTitle.bottomAnchor),
			self.productDescription.leftAnchor.constraint(equalTo: self.productThumb.rightAnchor, constant: 15),
			self.productDescription.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -10),
		])
	}
	
	// MARK: - Private
	
	private func getProductTitle(_ product: Product?, _ number: Int?) -> String {
		if let product = product {
			guard let number = number else {
				return product.title
			}

			return "x\(number) - \(product.title)"
		}
		
		return "product_unknown_title".translate()
	}
	
	private func getProductPrice(_ product: Product?, _ number: Int?) -> String {
		if let product = product {
			guard let number = number else {
				return product.price.toPriceValue()
			}
			
			let total = product.price * number
			return total.toPriceValue()
		}
		
		return "product_unknown_price".translate()
	}
	
	// MARK: - Product thumbnail handlers
	
	/// Called from the cell itself so the content know whenever specific data of the ad has been fetched and ready to be displayed.
	/// In this technical test, it will only be useful to handle the download of the ad picture.
	func setProductThumbnail(image: UIImage?) {
		guard let downloaded = image else {
			return
		}
		
		self.productThumb.image = downloaded
	}
	
	/// For some reason (eg. statusCode != 200), the data could not be fetched.
	/// In this case we display a placeholder.
	func setPlaceholderAsProductThumbnail() {
		let placeholder = UIImage(systemName: "photo")
		self.productThumb.contentMode = .center
		self.productThumb.image = placeholder?.withTintColor(.white)
		self.productThumb.tintColor = .white
	}
}
