//
//  Concentration.swift
//  Concentration
//
//  Created by 박혜원 on 2020/12/19.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int? // 뒤집혀진 카드의 인덱스를 저장하는 변수, 아무것도 뒤집혀 있지 않은 경우가 존재하므로 Optional Type이다.
    
    func chooseCard(at index: Int) {
        
        if !cards[index].isMached {
            // 뒤집혀진 카드의 index값을 matchIndex에 넣는다. 이떄, 뒤집혀진 카드가 동일한 카드임을 방지한다.
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // 실제 두개의 카드가 일치하는지 확인한다.
                if cards[matchIndex].identifier == cards[index].identifier {
                    // 실제 두 카드가 일치하는 경우
                    cards[matchIndex].isMached = true
                    cards[index].isMached = true
                }
                cards[index].isFaceUp = true // 일치하지 않은 경우에 대해서 사용자가 선택한 카드에 대한 isFaceUP은 true값을 가진다.
                indexOfOneAndOnlyFaceUpCard = nil // 두장의 카드가 뒤집혀 있는 경우
            } else {
                /*
                 일치하지 않는 경우 모든 카드를 다시 뒤집어야 하고
                 사용자가 선택한 값은 true로 만들고
                 indexOfOneAndOnlyFaceUpCard에 사용자가 선택한 index라는 매개변수로 indentifier 값을 할당해준다.
                */
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int ){
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle the cards
    }
}
