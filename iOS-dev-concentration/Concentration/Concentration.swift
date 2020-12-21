//
//  Concentration.swift
//  Concentration
//
//  Created by 박혜원 on 2020/12/19.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    /*
     뒤집어진 카드의 인덱스를 저장하는 것이 목적이 아니다.
     1. 뒤집어진 카드가 있는지
     2. 일치하지 않는 카드가 있는지
     변수를 활용할 때 결정된다.
     */
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex : Int?
            for index in cards.indices {
                if cards[index].isFaceUp { // 카드가 한장 뒤집어져 있는 상황
                    if foundIndex == nil { // 이전에 뒤집은 카드가 없는 경우
                        foundIndex = index
                    } else { // 이전에 뒤집은 카드가 있는 경우
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        
        // 존재하지 않는 index에 접근 하는 경우 console창에 에러메시지를 띄운다.
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)): chosen not in the cards")
        
        if !cards[index].isMached {
            // 뒤집혀진 카드의 index값을 matchIndex에 넣는다. 이떄, 뒤집혀진 카드가 동일한 카드임을 방지한다.
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // 실제 두개의 카드가 일치하는지 확인한다.
                if cards[matchIndex] == cards[index] {
                    // 실제 두 카드가 일치하는 경우
                    cards[matchIndex].isMached = true
                    cards[index].isMached = true
                }
                cards[index].isFaceUp = true // 일치하지 않은 경우에 대해서 사용자가 선택한 카드에 대한 isFaceUP은 true값을 가진다.
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int ){
        
        // 적어도 한쌍의 카드는 생성해야 한다.
        assert(numberOfPairsOfCards > 0 , "Concentration.init(\(numberOfPairsOfCards)): you must have at least on pair of cars")
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle the cards
        cards.shuffle()
        cards.shuffle()
    }
}
