//
//  ViewController.swift
//  BlackJack
//
//  Created by Student on 2/14/15.
//  Copyright (c) 2015 XiaoZhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var initmoney = 100
    var betmoney = 0
    var dcarddetail = ""
    var pcarddetail = ""
    var dscore = 0
    var pscore = 0
    var newgame: game!
    var gamecount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yourmoney.text = "Money: \(initmoney)"
        newgame = game()
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
            newgame.shuffle()
        }
        newgame.dcard.removeAll()
        newgame.pcard.removeAll()
        newgame.pcard.append(newgame.addcard())
        newgame.pcard.append(newgame.addcard())
        newgame.dcard.append(newgame.addcard())
        newgame.dcard.append(newgame.addcard())
        if (toDouble(inputmoney.text) == nil){
            let alertController = UIAlertController(title: "Warning", message: "Error input", preferredStyle:UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        betmoney = inputmoney.text.toInt()!
        if (betmoney < 1 || betmoney > initmoney){
            let alertController = UIAlertController(title: "Warning", message: "Error input", preferredStyle:UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        yourbet.text = "Bet: \(betmoney)"
        initmoney = initmoney - betmoney
        yourmoney.text = "Money: \(initmoney)"
        dcarddetail = "Hidden,"
        dcarddetail += newgame.dcard[1].description
        dealercard.text = dcarddetail
        pcarddetail = "\(newgame.pcard[0].description)"
        pcarddetail += newgame.pcard[1].description
        playercard.text = pcarddetail
        Deal.hidden = true
        inputmoney.hidden = true
        hit.hidden = false
        stand.hidden = false
        total.hidden = false
        yourbet.hidden = false
        inputbet.hidden = true
        dtotal.hidden = true
        pscore = caculatescore(newgame.pcard)
        dscore = caculatescore(newgame.dcard)
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
        initmoney = 100
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
        newgame.pcard.append(newgame.addcard())
        pcarddetail += newgame.pcard[newgame.pcard.count-1].description
        playercard.text = pcarddetail
        pscore = caculatescore(newgame.pcard)
        total.text = "Total: \(pscore)"
        if (pscore > 21){
            conclusion.text = "You lose"
            stopgame()
        }
    }

    
    @IBAction func Stand(sender: AnyObject) {
        while (dscore < 17){
            newgame.dcard.append(newgame.addcard())
            dscore = caculatescore(newgame.dcard)
        }
        pscore = caculatescore(newgame.pcard)
        dscore = caculatescore(newgame.dcard)
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
        for i in 0..<newgame.dcard.count{
            dcarddetail += newgame.dcard[i].description
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
            initmoney += betmoney*2
        }else if (conclusion.text == "Push"){
            initmoney += betmoney
        }
        yourmoney.text = "Money: \(initmoney)"
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

