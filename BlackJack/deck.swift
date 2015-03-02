//
//  deck.swift
//  BlackJack
//
//  Created by Student on 2/24/15.
//  Copyright (c) 2015 XiaoZhang. All rights reserved.
//

import Foundation

class deck{
    var deckcard = [BlackJackCard]()
    
    init(){
        createdeck()
    }
    
    //Create a deck of card
    func createdeck() {
        let suits = [Suit.Spades, Suit.Hearts, Suit.Diamonds, Suit.Clubs]
        let ranks = [Rank.Ace, Rank.Two, Rank.Three, Rank.Four, Rank.Five, Rank.Six, Rank.Seven, Rank.Eight, Rank.Nine, Rank.Ten, Rank.Jack, Rank.Queen, Rank.King]
        for i in 0...3{
            for j in 0...12{
                var card = BlackJackCard(rank: ranks[j], suit: suits[i])
                deckcard.append(card)
            }
        }
    }
    
}