//
//  game.swift
//  BlackJack
//
//  Created by 鸿烨 弓 on 15/2/15.
//  Copyright (c) 2015年 XiaoZhang. All rights reserved.
//

import Foundation

class game{
    var allcard = [BlackJackCard]()
    var pcard = [BlackJackCard]()
    var dcard = [BlackJackCard]()
    
    init() {
        shuffle()
    }
    func shuffle() {
        let suits = [Suit.Spades, Suit.Hearts, Suit.Diamonds, Suit.Clubs]
        let ranks = [Rank.Ace, Rank.Two, Rank.Three, Rank.Four, Rank.Five, Rank.Six, Rank.Seven, Rank.Eight, Rank.Nine, Rank.Ten, Rank.Jack, Rank.Queen, Rank.King]
        for i in 0...3{
            for j in 0...12{
                var card = BlackJackCard(rank: ranks[j], suit: suits[i])
                allcard.append(card)
            }
        }
    }
    
    func addcard() -> BlackJackCard{
        var randomindex = Int(arc4random_uniform(UInt32(allcard.count)))
        var newcard = allcard[randomindex]
        allcard.removeAtIndex(randomindex)
        return newcard
    }
    
    func daddcard(){

    }
    
}