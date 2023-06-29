//
//  ViewController.swift
//  Concentration
//
//  Created by Win Lwin on 29/06/2023.
//

import UIKit

class ViewController: UIViewController {
	
	lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2 )
	
	@IBOutlet weak var flipCountLabel: UILabel!
	private var flipCount = 0 {
		didSet {
			flipCountLabel.text = "Flips: \(flipCount)"
		}
	}
	
	
	@IBOutlet var cardButtons: [UIButton]!
	var emojiChoices = ["👻", "🐶", "🌚", "🎃", "🔥", "⛄️", "🍎", "🌹"]
	
	@IBAction func touchCard(_ sender: UIButton) {
		if let cardNumber = cardButtons.firstIndex(of: sender) {
			game.chooseCard(at: cardNumber)
			updateUI()
			flipCount += 1
		}
	}
	
	
	
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
	
	var emoji = [Int: String]()
	
	func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices.count > 0 {
			let randomIndex = cardButtons.count.arc4random() //Int(arc4random_uniform(UInt32(cardButtons.count)))
			emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
		}
		return emoji[card.identifier] ?? "?"
	}
	
}


