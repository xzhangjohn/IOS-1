//
//  hand.swift
//  BlackJack
//
//  Created by Xiao Zhang on 2/26/15.
//  Copyright (c) 2015 XiaoZhang. All rights reserved.
//

import Foundation

class hand{
    init() {
        
    }
    
    func caculatescore (cards:[BlackJackCard]) ->Int{
        var score = 0
        var flag = false
        for i in 0..<cards.count{
            score += cards[i].rank.values.first
            if (cards[i].rank.values.first == 1){
                flag = true
            }
        }
        if (flag == true && score <= 11){
            score += 10
        }
        return score
    }
    
    func addcard(var acard: [BlackJackCard]) -> BlackJackCard{
        var randomindex = Int(arc4random_uniform(UInt32(acard.count)))
        var newcard = acard[randomindex]
        acard.removeAtIndex(randomindex)
        return newcard
    }
    
}