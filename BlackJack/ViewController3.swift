//
//  ViewController3.swift
//  BlackJack
//
//  Created by Xiao Zhang on 2/28/15.
//  Copyright (c) 2015 XiaoZhang. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    var numDeck: Int = Int()
    var betmoney = 0
    var dcarddetail = ""
    var pcarddetail = ""
    var dscore = 0
    var pscore = 0
    var gamecount = 0
    var newshoe: shoe!
    var newdealer: dealer!
    var fplayer: player!
    var initmoney = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newshoe = shoe(decknum: numDeck)
        newdealer = dealer(dcard: [],dscore: 0)
        fplayer = player(pcard: [],pscore: 0, pmoney: 100)
        yourmoney.text = "Money: \(fplayer.pmoney)"
        hit.hidden = true
        stand.hidden = true
        total.hidden = true
        gameover.hidden = true
        dtotal.hidden = true
        yourbet.hidden = true
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
        // clear player and dealer cards
        newdealer.dcard.removeAll(keepCapacity: false)
        fplayer.pcard.removeAll(keepCapacity: false)
        
        // add new card to player and dealer
        fplayer.pcard.append(fplayer.addcard(newshoe.shoecard))
        fplayer.pcard.append(fplayer.addcard(newshoe.shoecard))
        
        // check input betmoney
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
        
        // show bet money
        yourbet.text = "Bet: \(betmoney)"
        fplayer.pmoney = fplayer.pmoney - betmoney
        initmoney = fplayer.pmoney
        yourmoney.text = "Money: \(fplayer.pmoney)"
        Deal.hidden = true
        inputmoney.hidden = true
        yourbet.hidden = false
        inputbet.hidden = true
        playercard.hidden = false
        dealercard.hidden = false
        conclusion.hidden = true
        pcarddetail = "\(fplayer.pcard[0].description)"
        pcarddetail += fplayer.pcard[1].description
        playercard.text = pcarddetail
        dealercard.text = dcarddetail
        hit.hidden = false
        stand.hidden = false
        total.hidden = false
        newdealer.dcard.append(newdealer.addcard(newshoe.shoecard))
        newdealer.dcard.append(newdealer.addcard(newshoe.shoecard))
        dtotal.hidden = true
        dcarddetail = "Hidden,"
        dcarddetail += newdealer.dcard[1].description
        dealercard.text = dcarddetail
            
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
        dcarddetail = ""
        pcarddetail = ""
        dscore = 0
        pscore = 0
        gamecount = 0
        initmoney = 100
        gameover.hidden = true
        Deal.hidden = false
        inputmoney.hidden = false
        inputbet.hidden = false
        yourbet.hidden = true
        playercard.text = ""
        dealercard.text = ""
        conclusion.text = "Let's play blackjack"
        viewDidLoad()
    }
    

    @IBAction func Hit(sender: AnyObject) {
        fplayer.pcard.append(fplayer.addcard(newshoe.shoecard))
        pcarddetail += fplayer.pcard[fplayer.pcard.count-1].description
        playercard.text = pcarddetail
        pscore = fplayer.caculatescore(fplayer.pcard)
        total.text = "Total: \(pscore)"
        if (pscore > 21){
            conclusion.text = "You lose"
            conclusion.hidden = false
            stopgame()
        }
    }
    
    

    @IBAction func Stand(sender: AnyObject) {
        hit.hidden = true
        stand.hidden = true
        stopgame()
    }
    
    
    
    func showdealer(){
        dcarddetail = ""
        for i in 0..<newdealer.dcard.count{
            dcarddetail += newdealer.dcard[i].description
        }
        dealercard.text = dcarddetail
    }
    

    
    func stopgame (){
        // show dealer card
        while (dscore < 17 && conclusion.hidden == true){
            newdealer.dcard.append(newdealer.addcard(newshoe.shoecard))
            dscore = newdealer.caculatescore(newdealer.dcard)
        }
        
        pscore = fplayer.caculatescore(fplayer.pcard)
        dscore = newdealer.caculatescore(newdealer.dcard)
        if (conclusion.hidden == true){
            if (dscore > 21){
                conclusion.text = "You won"
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
        }
        
        showdealer()
        conclusion.hidden = false
        Deal.hidden = false
        hit.hidden = true
        stand.hidden = true
        inputmoney.hidden = false
        yourbet.hidden = true
        inputbet.hidden = false
        dtotal.hidden = false
        dtotal.text = "Total: \(dscore)"
        
        // result
        if (conclusion.text == "You lose"){
        }else if (conclusion.text == "You won"){
            fplayer.pmoney += betmoney*2
        }else if (conclusion.text == "Push"){
            fplayer.pmoney += betmoney
        }
        yourmoney.text = "Money: \(fplayer.pmoney)"
        if (fplayer.pmoney < 1){
            Deal.hidden = true
            inputmoney.hidden = true
            inputbet.hidden = true
            gameover.hidden = false
        }
        
        
        // shuffle if game count > 4
        gamecount += 1
        if (gamecount > 4){
            gamecount = 0
            newshoe.initshoe(3)
        }
        
    }
    
    func toDouble(str: String) -> Double? {
        var formatter = NSNumberFormatter()
        if let number = formatter.numberFromString(str) {
            return number.doubleValue
        }
        return nil
    }
    
    
    
}

