//
//  shoe.swift
//  BlackJack
//
//  Created by Student on 2/24/15.
//  Copyright (c) 2015 XiaoZhang. All rights reserved.
//

import Foundation

class shoe{
    var shoecard = [BlackJackCard]()
    
    init(decknum: Int) {
        initshoe(decknum)
    }
    
    func initshoe(decknum: Int) {
        var newdeck: deck = deck()
        for i in 0..<decknum{
            for j in 0..<newdeck.deckcard.count{
                shoecard.append(newdeck.deckcard[j])
            }
        }
    }
}