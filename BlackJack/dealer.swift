//
//  dealer.swift
//  BlackJack
//
//  Created by Student on 2/24/15.
//  Copyright (c) 2015 XiaoZhang. All rights reserved.
//

import Foundation
class dealer: hand {
    var dcard: [BlackJackCard]
    var dscore: Int
    init(dcard: [BlackJackCard], dscore: Int){
        self.dcard = dcard
        self.dscore = dscore
        super.init()
    }
}