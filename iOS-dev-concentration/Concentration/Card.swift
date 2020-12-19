//
//  Card.swift
//  Concentration
//
//  Created by 박혜원 on 2020/12/19.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMached = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1 // Card.identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier =  Card.getUniqueIdentifier()
    }
}
