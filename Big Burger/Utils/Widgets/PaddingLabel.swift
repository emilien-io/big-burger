//
//  PaddingLabel.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation
import UIKit

/// UI element that helps to create a label with padding on left, top, right & bottom.
class PaddingLabel: UILabel {
	
	// MARK: - Properties
	
	var textEdgeInsets = UIEdgeInsets.zero {
		didSet { invalidateIntrinsicContentSize() }
	}
	
	var paddingLeft: CGFloat {
		set { textEdgeInsets.left = newValue }
		get { return textEdgeInsets.left }
	}
	
	var paddingRight: CGFloat {
		set { textEdgeInsets.right = newValue }
		get { return textEdgeInsets.right }
	}
	
	var paddingTop: CGFloat {
		set { textEdgeInsets.top = newValue }
		get { return textEdgeInsets.top }
	}
	
	var paddingBottom: CGFloat {
		set { textEdgeInsets.bottom = newValue }
		get { return textEdgeInsets.bottom }
	}
	
	// MARK: - Overriden Methods
	
	open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
		let insetRect = bounds.inset(by: textEdgeInsets)
		let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
		let invertedInsets = UIEdgeInsets(top: -textEdgeInsets.top, left: -textEdgeInsets.left, bottom: -textEdgeInsets.bottom, right: -textEdgeInsets.right)
		return textRect.inset(by: invertedInsets)
	}
	
	override func drawText(in rect: CGRect) {
		super.drawText(in: rect.inset(by: textEdgeInsets))
	}
}
