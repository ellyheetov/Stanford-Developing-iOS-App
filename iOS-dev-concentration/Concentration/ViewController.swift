//
//  ViewController.swift
//  Concentration
//
//  Created by 박혜원 on 2020/12/19.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2 )

    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flipse: \(flipCount)"
        }
    }
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["🦇", "😱", "🙀", "👿", "🎃", "👻", "🍭", "🍬", "🍎"]
    var emoji = [Int:String]()
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in carButtons")
        }
    }
    func flipCard(widthEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMached ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    /*
     카드 인자에 대해 emoji라는 함수가 호출되면 String 타입으로 반환한다.
     만약 유일한 구분자를 가지고 있는 카드에 매칭되는 이모지가 존재하지 않고,
     아직 emojiChoices에 이모지가 남아있다면,
     emojiChoices의 갯수 -1 까지 생성되는 임의의 숫자의 인덱스에 해당하는 emojiChoices 내의 이모지를 지우면서
     emoji 딕셔너리에 할당한다.
     그렇지 않은 경우에는 ? 를 반환한다.
     */
    func emoji(for card : Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

