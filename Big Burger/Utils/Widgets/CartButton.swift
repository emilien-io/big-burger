//
//  CartButton.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation
import UIKit

class CartButton: UIView {
	
	// MARK: - Properties
	
	private var nbItems: Int = 0
	
	private let container: UIView = {
		let view = UIView()
		return view
	}()
	
	private let cartImage: UIImageView = {
		let imageView = UIImageView()
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 5
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	private let indicator: PaddingLabel = {
		let label = PaddingLabel()
		label.textColor = .white
		label.backgroundColor = .clear
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
	
	// MARK: - Initialization
	
	convenience init(superview: UIView) {
		self.init(frame: CGRect(x: UIScreen.main.bounds.width - 100, y: UIScreen.main.bounds.height - 100, width: 70, height: 70))

		self.setupView()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	// MARK: - Private
	
	/// Bind the datas and setup the view.
	private func setupView() {
		self.container.frame = CGRect(origin: CGPoint(x: 5, y: 5), size: CGSize(width: self.frame.width - 10, height: self.frame.height - 10))
		self.container.backgroundColor = Appearance.mainColor
		self.container.layer.cornerRadius = self.container.frame.width / 2
		
		self.cartImage.frame = CGRect(x: 2, y: 2, width: self.container.frame.width - 4, height: self.container.frame.height - 4)
		self.cartImage.contentMode = .center
		self.cartImage.image = UIImage(systemName: "cart.fill")?.withTintColor(.white)
		self.cartImage.tintColor = .white
		
		self.container.addSubview(self.cartImage)
		self.container.addSubview(self.indicator)
		
		self.addSubview(self.container)
	}
	
	// MARK: - Public
	
	func increase() {
		self.nbItems += 1
		
		self.indicator.backgroundColor = .red
		self.indicator.text = self.nbItems > 9 ? "9+" : "\(nbItems)"
	}
	
}
