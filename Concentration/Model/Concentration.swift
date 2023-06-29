//
//  Concentration.swift
//  Concentration
//
//  Created by Win Lwin on 29/06/2023.
//

import Foundation

class Concentration {
	var cards = [Card]()
	
	func chooseCard(at index: Int) {
		if cards[index].isFaceup {
			cards[index].isFaceup = false
		} else {
			cards[index].isFaceup = true
		}
	}
	
	init(numberOfPairOfCards: Int) {
		for _ in 1...numberOfPairOfCards {
			let card = Card()
			cards += [card, card]
		}
	}
}
