//
//  ViewController.swift
//  Concentration
//
//  Created by 박혜원 on 2020/12/19.
//

import UIKit

class ViewController: UIViewController {

    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flipse: \(flipCount)"
        }
    }
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchSecondCard(_ sender: UIButton) {
        flipCard(widthEmoji: "🎃", on: sender)
    }
    @IBAction func touchCard(_ sender: UIButton) {
        flipCard(widthEmoji: "👻", on: sender)
    }
    func flipCard(widthEmoji emoji: String, on button: UIButton){
        flipCount += 1
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

