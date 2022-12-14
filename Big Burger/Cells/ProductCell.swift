//
//  ProductCell.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import UIKit

class ProductCell: UITableViewCell {
	
	// MARK: - Properties
	
	private var content: ProductCellContent = ProductCellContent()
	
	// MARK: - Overriden Methods

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	// MARK: - Public
	
	/// Initialize a `ProductCell` cell.
	/// - Parameters:
	///   - product: Product data.
	func initializeCell(withProduct product: Product?, occurence number: Int? = nil) {
		self.backgroundColor = Appearance.backgroundColor
		self.addSubview(self.content)
		
		self.content.setupView(product, number)
		self.content.addConstraints()
		
		self.getProductPicture(for: product)
	}
	
	// MARK: - Private
	
	/// Asynchronously fetch product picture.
	private func getProductPicture(for product: Product?) {
		guard let url = URL(string: product?.thumbnail ?? "") else {
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
