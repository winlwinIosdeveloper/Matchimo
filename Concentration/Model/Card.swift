//
//  File.swift
//  Concentration
//
//  Created by Win Lwin on 29/06/2023.
//

import Foundation

struct Card {
	var isFaceup = false
	var isMatch = false
	var identifier: Int
	
	static var identifierFactory = 0
	
	static func getUniqueIdentifier() -> Int {
		Card.identifierFactory += 1
		return identifierFactory
	}
	
	init() {
		self.identifier = Card.getUniqueIdentifier()
	}
	
}
