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
		self.view = self.content
    }
    
}
