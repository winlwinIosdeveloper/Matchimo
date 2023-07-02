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
	
	
	
	// MARK: Emoji Declarition Stuff
	var emojiChoice: [String]?
	var emojiTheme: String?
	private let theme = [ "Animals": ["🐶", "🦊", "🐼", "🦁", "🐷", "🐵", "🐔", "🦆", "🦉", "🦅"],
						 "Fruits": ["🍏", "🍐", "🍊", "🍓", "🍉", "🍒", "🥑", "🥦", "🥕", "🌽"],
						 "Activity": ["⚽️", "🏀", "🏈", "🎱", "🏓", "🏏", "🥊", "🏹", "⛸", "🛹"] ]
	
	private func emojiChoices() -> (String?, [String]?) {
		let key = theme.randomElement()?.key
		let value = theme[key!]
		return (key, value)
	}
	
	private func configureEmoji() {
		(emojiTheme, emojiChoice) = emojiChoices()
		print(emojiTheme!)
		print(emojiChoice!)
	}
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureEmoji()
		updateBackgroundTheme()
	}
	
	
	
	@IBOutlet weak var flipCountLabel: UILabel! {
		didSet {
			flipCountLabel.text = "Flips: \(game.flipCount)"
		}
	}
	
	@IBOutlet weak var scoreLabel: UILabel! {
		didSet {
			scoreLabel.text = "Scores: \(game.scores)"
		}
	}
	

	@IBOutlet var cardButtons: [UIButton]!
	
	
	
	// MARK: Touch Card
	@IBAction func touchCard(_ sender: UIButton) {
		if let cardNumber = cardButtons.firstIndex(of: sender) {
			game.chooseCard(at: cardNumber)
			updateUI()
			game.flipCount += 1
		}
	}
	
	var emoji = [Int: String]() // Dictionary to add random emoji on demand touch card
	func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoice!.count > 0 {
			let randomIndex = emojiChoice!.count.arc4random()
			print(randomIndex)
			//Int(arc4random_uniform(UInt32(cardButtons.count)))
			emoji[card.identifier] = emojiChoice!.remove(at: randomIndex)
		}
		return emoji[card.identifier] ?? "?"
	}
	
	
	
	// MARK: - update view from model
	func updateUI() {
		for index in cardButtons.indices {
			let button = cardButtons[index]
			if game.cards[index].isFaceup {
				button.setTitle(emoji(for: game.cards[index]), for: UIControl.State.normal)
				button.backgroundColor = .white
			} else {
				button.setTitle("", for: UIControl.State.normal)
				button.backgroundColor = game.cards[index].isMatch ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 0.5)
			}
			flipCountLabel.text = "Flips: \(game.flipCount)"
			scoreLabel.text = "Scores: \(game.scores)"
		}
	}
	
	
	
	// MARK: New Game
	@IBAction func makeNewGame(_ sender: UIButton) {
		emoji.removeAll()
		emojiChoice?.removeAll()
		configureEmoji()
	
		game.flipCount = 0
		game.scores = 0
		
		for index in cardButtons.indices {
			game.cards[index].isMatch = false
			game.cards[index].isFaceup = false

		}
		updateBackgroundTheme()
		updateUI()	
	}
	
	
	
	// MARK: Background Theme
	private func updateBackgroundTheme() {
		switch emojiTheme! {
		case "Fruits":
			view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
		case "Animals":
			view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
		case "Activity":
			view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
		default:
			view.backgroundColor = .systemBackground
		}
	}
	
}


