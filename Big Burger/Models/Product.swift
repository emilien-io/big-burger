//
//  Product.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation

/// Product model
struct Product {
	let ref: String
	let title: String
	let description: String
	let thumbnail: String
	let price: Int
}

/// Decodable coding keys
extension Product: Decodable {
	enum CodingKeys: String, CodingKey {
		case ref = "ref"
		case title = "title"
		case description = "description"
		case thumbnail = "thumbnail"
		case price = "price"
	}
}
