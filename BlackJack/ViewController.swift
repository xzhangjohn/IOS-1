//
//  ViewController.swift
//  BlackJack
//
//  Created by Student on 2/14/15.
//  Copyright (c) 2015 XiaoZhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var betmoney = 0
    var dcarddetail = ""
    var pcarddetail = ""
    var dscore = 0
    var pscore = 0
    var gamecount = 0
    var newshoe: shoe!
    var newdealer: dealer!
    var fplayer: player!
    var splayer: player!
    var initmoney = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newshoe = shoe(decknum: 3)
        newdealer = dealer(dcard: [],dscore: 0)
        fplayer = player(pcard: [],pscore: 0, pmoney: 100)
        splayer = player(pcard: [],pscore: 0, pmoney: 100)
        yourmoney.text = "Money: \(fplayer.pmoney)"
        hit.hidden = true
        stand.hidden = true
        total.hidden = true
        dtotal.hidden = true
        gameover.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var yourmoney: UILabel!
    @IBOutlet weak var inputmoney: UITextField!
    @IBOutlet weak var yourbet: UILabel!
    @IBOutlet weak var dealercard: UILabel!
    @IBOutlet weak var playercard: UILabel!
    @IBOutlet weak var hit: UIButton!
    @IBOutlet weak var gameover: UIButton!
    @IBOutlet weak var dtotal: UILabel!
    @IBOutlet weak var conclusion: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var stand: UIButton!
    @IBOutlet weak var Deal: UIButton!
    
    @IBOutlet weak var inputbet: UILabel!
    @IBAction func Deal(sender: AnyObject) {
        gamecount += 1
        if (gamecount > 4){
            gamecount = 0
            newshoe.initshoe(3)
        }
        newdealer.dcard.removeAll(keepCapacity: false)
        fplayer.pcard.removeAll(keepCapacity: false)
        fplayer.pcard.append(fplayer.addcard(newshoe.shoecard))
        fplayer.pcard.append(fplayer.addcard(newshoe.shoecard))
        newdealer.dcard.append(newdealer.addcard(newshoe.shoecard))
        newdealer.dcard.append(newdealer.addcard(newshoe.shoecard))
        if (toDouble(inputmoney.text) == nil){
            let alertController = UIAlertController(title: "Warning", message: "Error input", preferredStyle:UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        betmoney = inputmoney.text.toInt()!
        if (betmoney < 1 || betmoney > fplayer.pmoney){
            let alertController = UIAlertController(title: "Warning", message: "Error input", preferredStyle:UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        yourbet.text = "Bet: \(betmoney)"
        initmoney = fplayer.pmoney - betmoney
        yourmoney.text = "Money: \(fplayer.pmoney)"
        pcarddetail = "\(fplayer.pcard[0].description)"
        pcarddetail += fplayer.pcard[1].description
        playercard.text = pcarddetail
        dcarddetail = "Hidden,"
        dcarddetail += newdealer.dcard[1].description
        dealercard.text = dcarddetail
        Deal.hidden = true
        inputmoney.hidden = true
        hit.hidden = false
        stand.hidden = false
        total.hidden = false
        yourbet.hidden = false
        inputbet.hidden = true
        dtotal.hidden = true
        pscore = fplayer.caculatescore(fplayer.pcard)
        dscore = newdealer.caculatescore(newdealer.dcard)
        total.text = "Total: \(pscore)"
        if (pscore == 21 && dscore != 21){
            conclusion.text = "You won"
             stopgame()
        }
        else if (dscore == 21 && pscore != 21){
            conclusion.text = "You lose"
             stopgame()
        }else if (dscore == 21 && dscore == pscore){
            conclusion.text = "push"
             stopgame()
        }else{
            conclusion.hidden = true
        }
    }
    
    @IBAction func restart(sender: AnyObject) {
        betmoney = 0
        gamecount = 0
        gameover.hidden = true
        Deal.hidden = false
        inputmoney.hidden = false
        inputbet.hidden = false
        yourbet.hidden = true
        conclusion.hidden = true
        viewDidLoad()
    }
    
    @IBAction func Hit(sender: UIButton) {
        fplayer.pcard.append(fplayer.addcard(newshoe.shoecard))
        pcarddetail += fplayer.pcard[fplayer.pcard.count-1].description
        playercard.text = pcarddetail
        pscore = fplayer.caculatescore(fplayer.pcard)
        total.text = "Total: \(pscore)"
        if (pscore > 21){
            conclusion.text = "You lose"
            stopgame()
        }
    }

    
    @IBAction func Stand(sender: AnyObject) {
        while (dscore < 17){
            newdealer.dcard.append(newdealer.addcard(newshoe.shoecard))
            dscore = caculatescore(newdealer.dcard)
        }
        pscore = fplayer.caculatescore(fplayer.pcard)
        dscore = newdealer.caculatescore(newdealer.dcard)
        if (pscore > 21){
            conclusion.text = "You lose"
        }
        else if (dscore > 21){
            conclusion.text = "You won"
        }
        else if (pscore == 21 && dscore != 21){
            conclusion.text = "You won"
        }
        else if (dscore == 21 && pscore != 21){
            conclusion.text = "You lose"
        }
        else if (pscore > dscore){
            conclusion.text = "You won"
        }
        else if (pscore < dscore){
            conclusion.text = "You lose"
        }
        else{
            conclusion.text = "Push"
        }
        stopgame ()
    }
    
    func showdealer(){
        dcarddetail = ""
        for i in 0..<newdealer.dcard.count{
            dcarddetail += newdealer.dcard[i].description
        }
        dealercard.text = dcarddetail
    }
    
    func stopgame (){
        showdealer()
        Deal.hidden = false
        inputmoney.hidden = false
        hit.hidden = true
        stand.hidden = true
        conclusion.hidden = false
        yourbet.hidden = true
        inputbet.hidden = false
        dtotal.hidden = false
        dtotal.text = "Total: \(dscore)"
        if (conclusion.text == "You lose"){
        }else if (conclusion.text == "You won"){
            fplayer.pmoney += betmoney*2
        }else if (conclusion.text == "Push"){
            fplayer.pmoney += betmoney
        }
        yourmoney.text = "Money: \(fplayer.pmoney)"
        if (initmoney < 1){
            gameover.hidden = false
            Deal.hidden = true
            inputmoney.hidden = true
            inputbet.hidden = true
        }
    }
    
    func toDouble(str: String) -> Double? {
        var formatter = NSNumberFormatter()
        if let number = formatter.numberFromString(str) {
            return number.doubleValue
        }
        return nil
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
    
    
}

