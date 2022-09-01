//
//  Int.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation

extension Int {
	func toPriceValue() -> String {
		let value: Double = Double(self) / 100.0
		return String(format: "%.2f", value)
	}
}
