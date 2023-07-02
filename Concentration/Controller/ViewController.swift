//
//  ViewController.swift
//  Concentration
//
//  Created by Win Lwin on 29/06/2023.
//

import UIKit

class ViewController: UIViewController {
	// MARK: - initialized Game model
	lazy var game = Concentration(numberOfPairOfCards: numberOfPairOfCards)
	
	private var numberOfPairOfCards: Int {
		(cardButtons.count + 1) / 2
	}
	
	@IBOutlet weak var flipCountLabel: UILabel!
	private var flipCount = 0 {
		didSet {
			flipCountLabel.text = "Flips: \(flipCount)"
		}
	}
	
	
	@IBOutlet var cardButtons: [UIButton]!
	
	
	@IBAction func touchCard(_ sender: UIButton) {
		if let cardNumber = cardButtons.firstIndex(of: sender) {
			game.chooseCard(at: cardNumber)
			updateUI()
			flipCount += 1
		}
	}
	
	
	// MARK: - update view from model
	func updateUI() {
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceup {
				button.setTitle(emoji(for: card), for: UIControl.State.normal)
				button.backgroundColor = .white
			} else {
				button.setTitle("", for: UIControl.State.normal)
				button.backgroundColor = card.isMatch ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1)
			}
		}
	}
	
	
	var emojiChoices = ["👻", "🐶", "🌚", "🎃", "🔥", "⛄️", "🍎", "🌹", "🌻" , "⭐️", "☃️", "🍓", "🍏", "🌶", "⚽️", "🎲"]
	var emoji = [Int: String]() // Dictionary to add random emoji on demand touch card
	
	func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices.count > 0 {
			let randomIndex = emojiChoices.count.arc4random()
			print(randomIndex)
			//Int(arc4random_uniform(UInt32(cardButtons.count)))
			emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
		}
		return emoji[card.identifier] ?? "?"
	}
	
	
	
	@IBAction func makeNewGame(_ sender: UIButton) {
		for index in game.cards.indices {
			game.cards[index].isMatch = false
			game.cards[index].isFaceup = false
		}
		updateUI()
	}
	
}


