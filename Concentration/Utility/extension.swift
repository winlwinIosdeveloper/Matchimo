//
//  extension.swift
//  Concentration
//
//  Created by Win Lwin on 29/06/2023.
//

import Foundation

extension Int {
	func arc4random() -> Int {
		if self > 0 {
			return Int(arc4random_uniform(UInt32(self)))
		} else if self < 0 {
			return -Int(arc4random_uniform(UInt32(self)))
		} else {
			return 0
		}
	}
}

