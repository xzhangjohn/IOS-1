//
//  player.swift
//  BlackJack
//
//  Created by Student on 2/24/15.
//  Copyright (c) 2015 XiaoZhang. All rights reserved.
//

import Foundation
class player: hand {
    var pcard: [BlackJackCard]
    var pscore: Int
    var pmoney: Int
    init(pcard: [BlackJackCard], pscore: Int, pmoney: Int){
        self.pcard = pcard
        self.pscore = pscore
        self.pmoney = pmoney
        super.init()
    }
}