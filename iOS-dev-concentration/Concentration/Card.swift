//
//  Card.swift
//  Concentration
//
//  Created by 박혜원 on 2020/12/19.
//

import Foundation

struct Card : Hashable {
    var isFaceUp = false
    var isMached = false
    private var identifier: Int
    
    var hashValue: Int { return identifier }
    
    private static var identifierFactory = 0
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1 // Card.identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier =  Card.getUniqueIdentifier()
    }
}
