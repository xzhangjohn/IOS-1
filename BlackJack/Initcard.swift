//
//  Initcard.swift
//  BlackJack
//
//  Created by Student on 2/14/15.
//  Copyright (c) 2015 XiaoZhang. All rights reserved.
//

import Foundation
//init card object

    enum Suit: Character{
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }

struct BlackJackCard {
    let rank: Rank, suit: Suit
    var description: String {
        var output = "\(suit.rawValue)"
        output += "\(rank.values.first)"
        return output
    }
}
