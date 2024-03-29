//
//  Concentration.swift
//  Concentration
//
//  Created by Win Lwin on 29/06/2023.
//

import Foundation

class Concentration {
	var cards = [Card]()
	
	var flipCount = 0
	var scores = 0
	
	private var indexOfOnlyAndOnlyFaceupCard: Int? {
		get {
			var foundIndex: Int?
			for index in cards.indices {
				if cards[index].isFaceup {
					if foundIndex == nil {
						foundIndex = index
					} else {
						return nil
					}
				}
			}
			return foundIndex
		}
		set {
			for index in cards.indices {
				cards[index].isFaceup = (index == newValue)
			}
		}
	}
	
	
	func chooseCard(at index: Int) {
		// to implement
		if !cards[index].isMatch {
			if let matchIndex = indexOfOnlyAndOnlyFaceupCard, matchIndex != index {
				//check if card match
				if cards[matchIndex].identifier == cards[index].identifier {
					cards[matchIndex].isMatch = true
					cards[index].isMatch = true
					scores += 4
				}
				cards[index].isFaceup = true
				scores -= 1
			} else {
				indexOfOnlyAndOnlyFaceupCard = index
			}
		}
		flipCount += 1
	}
	
	
	init(numberOfPairOfCards: Int) {
		for _ in 1...numberOfPairOfCards {
			let card = Card()
			cards += [card, card]
			cards.shuffle()
		}
	}
}

