//
//  ProductView.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import UIKit

/// Delegates that helps us to known whenever a user pressed on "Add to cart" from the view, in the controller.
protocol ProductViewDelegate {
	/// User want to add the product to the cart.
	func addToCart()
}

class ProductView: UIView {
	
	var delegate: ProductViewDelegate?
	
	// MARK: - UI Properties
	
	let productTitle: UILabel = {
		let label = UILabel()
		label.textColor = .black | .white
		label.font = UIFont(name: "Futura-Medium", size: 20)
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
		label.backgroundColor = .black
		label.paddingTop = 4
		label.paddingLeft = 5
		label.paddingRight = 5
		label.paddingBottom = 4
		label.font = UIFont(name: "AvenirNext-Bold", size: 12)
		label.clipsToBounds = true
		label.layer.cornerRadius = 5
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let productThumb: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = Appearance.mainColor
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 5
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	let addToCart: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = Appearance.mainColor
		button.clipsToBounds = true
		button.layer.cornerRadius = 10
		button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 16)
		button.setTitle("product_add_cart".translate(), for: .normal)
		button.addTarget(nil, action: #selector(addToCartTapped), for: .touchUpInside)
		return button
	}()
	
	// MARK: - Methods
	
	/// Bind the datas and setup the view.
	func setupView(_ product: Product?) {
		self.backgroundColor = .white
		
		self.productTitle.text = product?.title ?? "product_unknown_title".translate()
		self.productPrice.text = product?.price == nil ? "product_unknown_price".translate() : "\(product?.price.toPriceValue() ?? "0") €"
		self.productDescription.text = product?.description ?? "product_unknown_description".translate()
		
		self.addSubview(self.productThumb)
		self.addSubview(self.productTitle)
		self.addSubview(self.productPrice)
		self.addSubview(self.productDescription)
		self.addSubview(self.addToCart)
	}
	
	/// Setup the layout by adding constraints.
	func addConstraints() {
		self.productThumb.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
		
		NSLayoutConstraint.activate([
			self.productTitle.topAnchor.constraint(equalTo: self.productThumb.bottomAnchor, constant: 20),
			self.productTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
			self.productTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
			self.productTitle.heightAnchor.constraint(equalToConstant: 40),
			
			self.productPrice.bottomAnchor.constraint(equalTo: self.productThumb.bottomAnchor, constant: -10),
			self.productPrice.rightAnchor.constraint(equalTo: self.productThumb.rightAnchor, constant: -10),
			
			self.productDescription.topAnchor.constraint(equalTo: self.productTitle.bottomAnchor),
			self.productDescription.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
			self.productDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
			
			self.addToCart.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
			self.addToCart.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
			self.addToCart.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
			self.addToCart.heightAnchor.constraint(equalToConstant: 40)
		])
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
	
	// MARK: - OBJC Methods
	
	@objc func addToCartTapped() {
		self.delegate?.addToCart()
	}
}
