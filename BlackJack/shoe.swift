//
//  shoe.swift
//  BlackJack
//
//  Created by Student on 2/24/15.
//  Copyright (c) 2015 XiaoZhang. All rights reserved.
//

import Foundation

class shoe{
    var decknum = 3
    var shoecard = [deck]()
    
    func initshoe() {
        for i in 0..<decknum{
            var newdeckcard: deck = deck()
            //newdeckcard = deck()
            shoecard.append(newdeckcard)
        }
        
    }
    
    
}