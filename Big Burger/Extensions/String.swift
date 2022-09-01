//
//  String.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation

extension String {
	
	/// Helps to localize a key to return its translated value.
	/// - Returns: Returns the translated value of a content key.
	func translate() -> String {
		return NSLocalizedString(self, comment: "")
	}
}
