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
    var betmoney2 = 0
    var dcarddetail = ""
    var pcarddetail = ""
    var pcarddetail2 = ""
    var dscore = 0
    var pscore = 0
    var pscore2 = 0
    var gamecount = 0
    var newshoe: shoe!
    var newdealer: dealer!
    var fplayer: player!
    var splayer: player!
    var initmoney = 100
    var initmoney2 = 100
    var wait = 0
    var playernum = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newshoe = shoe(decknum: 3)
        newdealer = dealer(dcard: [],dscore: 0)
        fplayer = player(pcard: [],pscore: 0, pmoney: 100)
        splayer = player(pcard: [],pscore: 0, pmoney: 100)
        yourmoney.text = "Money: \(fplayer.pmoney)"
        yourmoney2.text = "Money: \(splayer.pmoney)"
        hit.hidden = true
        stand.hidden = true
        total.hidden = true
        gameover.hidden = true
        hit2.hidden = true
        stand2.hidden = true
        total2.hidden = true
        dtotal.hidden = true
        yourbet.hidden = true
        yourbet2.hidden = true
        gameover.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var yourmoney: UILabel!
    @IBOutlet weak var yourmoney2: UILabel!
    @IBOutlet weak var inputmoney: UITextField!
    @IBOutlet weak var inputmoney2: UITextField!
    @IBOutlet weak var yourbet: UILabel!
    @IBOutlet weak var yourbet2: UILabel!
    @IBOutlet weak var dealercard: UILabel!
    @IBOutlet weak var playercard: UILabel!
    @IBOutlet weak var playercard2: UILabel!
    @IBOutlet weak var hit: UIButton!
    @IBOutlet weak var hit2: UIButton!
    @IBOutlet weak var gameover: UIButton!
    @IBOutlet weak var dtotal: UILabel!
    @IBOutlet weak var conclusion: UILabel!
    @IBOutlet weak var conclusion2: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var total2: UILabel!
    @IBOutlet weak var stand: UIButton!
    @IBOutlet weak var stand2: UIButton!
    @IBOutlet weak var Deal: UIButton!
    @IBOutlet weak var Deal2: UIButton!
    @IBOutlet weak var inputbet: UILabel!
    @IBOutlet weak var inputbet2: UILabel!
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
        
        wait = wait + 1
        if (wait == 2){
            start()
        }
        if (playernum == 1){
            wait = 0
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
                stopplayer1()
            }
            else if (dscore == 21 && pscore != 21){
                conclusion.text = "You lose"
                stopplayer1()
            }else if (dscore == 21 && dscore == pscore){
                conclusion.text = "push"
                stopplayer1()
            }else{
                conclusion.hidden = true
            }
        }
    }
    
    @IBAction func Deal2(sender: AnyObject) {
        // clear player and dealer cards
        newdealer.dcard.removeAll(keepCapacity: false)
        splayer.pcard.removeAll(keepCapacity: false)
        
        // add new card to player and dealer
        splayer.pcard.append(splayer.addcard(newshoe.shoecard))
        splayer.pcard.append(splayer.addcard(newshoe.shoecard))
        
        // check input betmoney
        if (toDouble(inputmoney2.text) == nil){
            let alertController = UIAlertController(title: "Warning", message: "Error input", preferredStyle:UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        betmoney2 = inputmoney2.text.toInt()!
        if (betmoney2 < 1 || betmoney2 > splayer.pmoney){
            let alertController = UIAlertController(title: "Warning", message: "Error input", preferredStyle:UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        // show bet money
        yourbet2.text = "Bet: \(betmoney2)"
        splayer.pmoney = splayer.pmoney - betmoney2
        initmoney = splayer.pmoney
        yourmoney2.text = "Money: \(splayer.pmoney)"
        Deal2.hidden = true
        inputmoney2.hidden = true
        yourbet2.hidden = false
        inputbet2.hidden = true
        
        wait = wait + 1
        if (wait == 2){
            start()
        }
        
        if (playernum == 1){
            wait = 0
    
            pcarddetail2 = "\(splayer.pcard[0].description)"
            pcarddetail2 += splayer.pcard[1].description
            playercard2.text = pcarddetail2
            Deal2.hidden = true
            inputmoney2.hidden = true
            hit2.hidden = false
            stand2.hidden = false
            total2.hidden = false
            yourbet2.hidden = false
            inputbet2.hidden = true
            
            newdealer.dcard.append(newdealer.addcard(newshoe.shoecard))
            newdealer.dcard.append(newdealer.addcard(newshoe.shoecard))
            dtotal.hidden = true
            dcarddetail = "Hidden,"
            dcarddetail += newdealer.dcard[1].description
            dealercard.text = dcarddetail
            dscore = newdealer.caculatescore(newdealer.dcard)

            pscore2 = splayer.caculatescore(splayer.pcard)
            total2.text = "Total: \(pscore2)"
            if (pscore2 == 21 && dscore != 21){
                conclusion2.text = "You won"
                stopplayer2()
            }
            else if (dscore == 21 && pscore2 != 21){
                conclusion2.text = "You lose"
                stopplayer2()
            }else if (dscore == 21 && dscore == pscore2){
                conclusion2.text = "push"
                stopplayer2()
            }else{
                conclusion2.hidden = true
            }
        }
    }
    
    
    func start(){
        wait = 0
        pcarddetail = "\(fplayer.pcard[0].description)"
        pcarddetail += fplayer.pcard[1].description
        playercard.text = pcarddetail
        dealercard.text = dcarddetail
        hit.hidden = false
        stand.hidden = false
        total.hidden = false
        
        pcarddetail2 = "\(splayer.pcard[0].description)"
        pcarddetail2 += splayer.pcard[1].description
        playercard2.text = pcarddetail2
        Deal2.hidden = true
        inputmoney2.hidden = true
        hit2.hidden = false
        stand2.hidden = false
        total2.hidden = false
        yourbet2.hidden = false
        inputbet2.hidden = true
        
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
            stopplayer1()
        }
        else if (dscore == 21 && pscore != 21){
            conclusion.text = "You lose"
            stopplayer1()
        }else if (dscore == 21 && dscore == pscore){
            conclusion.text = "push"
            stopplayer1()
        }else{
            conclusion.hidden = true
        }
        
        pscore2 = splayer.caculatescore(splayer.pcard)
        total2.text = "Total: \(pscore2)"
        if (pscore2 == 21 && dscore != 21){
            conclusion2.text = "You won"
            stopplayer2()
        }
        else if (dscore == 21 && pscore2 != 21){
            conclusion2.text = "You lose"
            stopplayer2()
        }else if (dscore == 21 && dscore == pscore2){
            conclusion2.text = "push"
            stopplayer2()
        }else{
            conclusion2.hidden = true
        }
    }
    
    @IBAction func restart(sender: AnyObject) {
        betmoney = 0
        betmoney2 = 0
        dcarddetail = ""
        pcarddetail = ""
        pcarddetail2 = ""
        dscore = 0
        pscore = 0
        pscore2 = 0
        gamecount = 0
        initmoney = 100
        initmoney2 = 100
        wait = 0
        playernum = 2
        gameover.hidden = true
        Deal.hidden = false
        inputmoney.hidden = false
        inputbet.hidden = false
        yourbet.hidden = true
        conclusion.hidden = true
        Deal2.hidden = false
        inputmoney2.hidden = false
        inputbet2.hidden = false
        yourbet2.hidden = true
        conclusion2.hidden = true
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
            stopplayer1()
        }
    }

    
    @IBAction func Stand(sender: AnyObject) {
        hit.hidden = true
        stand.hidden = true
        wait += 1
        if (wait == 2){
            stopgame()
        }
        if (playernum == 1){
            stopplayer1()
        }
    }
    
    @IBAction func Hit2(sender: AnyObject) {
        splayer.pcard.append(splayer.addcard(newshoe.shoecard))
        pcarddetail2 += splayer.pcard[splayer.pcard.count-1].description
        playercard2.text = pcarddetail2
        pscore2 = splayer.caculatescore(splayer.pcard)
        total2.text = "Total: \(pscore2)"
        if (pscore2 > 21){
            conclusion2.text = "You lose"
            stopplayer2()
        }
    }
    
    @IBAction func Stand2(sender: AnyObject) {
        hit2.hidden = true
        stand2.hidden = true
        wait += 1
        if (wait == 2){
            stopgame()
        }
        if (playernum == 1){
            stopplayer2()
        }
    }
    
    
    func showdealer(){
        dcarddetail = ""
        for i in 0..<newdealer.dcard.count{
            dcarddetail += newdealer.dcard[i].description
        }
        dealercard.text = dcarddetail
    }
    
    func stopplayer1(){
        hit.hidden = true
        stand.hidden = true
        conclusion.hidden = false
        wait += 1
        if (wait == 2 && playernum == 2){
            stopgame()
        }
        if (playernum == 1){
            stopgameplayer1()
        }
    }
    
    func stopplayer2(){
        hit2.hidden = true
        stand2.hidden = true
        conclusion2.hidden = false
        wait += 1
        if (wait == 2 && playernum == 2){
            stopgame()
        }
        if (playernum == 1){
            stopgameplayer2()
        }
    }
    
    func stopgameplayer1(){
        // show dealer card
        while (dscore < 17){
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
            playernum = playernum - 1
        }
        
        if (playernum == 0){
            gameover.hidden = false
        }
        
        // shuffle if game count > 4
        gamecount += 1
        if (gamecount > 4){
            gamecount = 0
            newshoe.initshoe(3)
        }
        
        wait = 0
        newdealer.dcard.removeAll(keepCapacity: false)
        fplayer.pcard.removeAll(keepCapacity: false)
    }
    
    func stopgameplayer2(){
        // show dealer card
        while (dscore < 17){
            newdealer.dcard.append(newdealer.addcard(newshoe.shoecard))
            dscore = newdealer.caculatescore(newdealer.dcard)
        }
        
        pscore2 = splayer.caculatescore(splayer.pcard)
        dscore = newdealer.caculatescore(newdealer.dcard)
        
        if (conclusion2.hidden == true){
            if (dscore > 21){
                conclusion2.text = "You won"
            }
            else if (pscore2 > dscore){
                conclusion2.text = "You won"
            }
            else if (pscore2 < dscore){
                conclusion2.text = "You lose"
            }
            else{
                conclusion2.text = "Push"
            }
        }
        showdealer()
        conclusion2.hidden = false
        Deal2.hidden = false
        inputmoney2.hidden = false
        yourbet2.hidden = true
        inputbet2.hidden = false
        dtotal.hidden = false
        dtotal.text = "Total: \(dscore)"
        
        // result
        if (conclusion2.text == "You lose"){
        }else if (conclusion2.text == "You won"){
            splayer.pmoney += betmoney2*2
        }else if (conclusion2.text == "Push"){
            splayer.pmoney += betmoney2
        }
        yourmoney2.text = "Money: \(splayer.pmoney)"
        
        if (splayer.pmoney  < 1){
            Deal2.hidden = true
            inputmoney2.hidden = true
            inputbet2.hidden = true
            playernum = playernum - 1
        }
        if (playernum == 0){
            gameover.hidden = false
        }
        
        
        // shuffle if game count > 4
        gamecount += 1
        if (gamecount > 4){
            gamecount = 0
            newshoe.initshoe(3)
        }
        
        wait = 0
        newdealer.dcard.removeAll(keepCapacity: false)
        splayer.pcard.removeAll(keepCapacity: false)
    }
    
    func stopgame (){
        // show dealer card
        while (dscore < 17){
            newdealer.dcard.append(newdealer.addcard(newshoe.shoecard))
            dscore = newdealer.caculatescore(newdealer.dcard)
        }
        
        pscore = fplayer.caculatescore(fplayer.pcard)
        pscore2 = splayer.caculatescore(splayer.pcard)
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
        
        if (conclusion2.hidden == true){
        if (dscore > 21){
            conclusion2.text = "You won"
        }
        else if (pscore2 > dscore){
            conclusion2.text = "You won"
        }
        else if (pscore2 < dscore){
            conclusion2.text = "You lose"
        }
        else{
            conclusion2.text = "Push"
        }
        }
        showdealer()
        conclusion.hidden = false
        conclusion2.hidden = false
        Deal.hidden = false
        Deal2.hidden = false
        inputmoney.hidden = false
        inputmoney2.hidden = false
        yourbet.hidden = true
        inputbet.hidden = false
        yourbet2.hidden = true
        inputbet2.hidden = false
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
            playernum = playernum - 1
            yourbet.text = "Game Over"
            yourbet.hidden = false
        }
        
        if (conclusion2.text == "You lose"){
        }else if (conclusion2.text == "You won"){
            splayer.pmoney += betmoney2*2
        }else if (conclusion2.text == "Push"){
            splayer.pmoney += betmoney2
        }
        yourmoney2.text = "Money: \(splayer.pmoney)"
        
        if (splayer.pmoney  < 1){
            Deal2.hidden = true
            inputmoney2.hidden = true
            inputbet2.hidden = true
            playernum = playernum - 1
            yourbet2.text = "Game Over"
            yourbet2.hidden = false
        }
        if (playernum == 0){
            gameover.hidden = false
        }
        
        
        // shuffle if game count > 4
        gamecount += 1
        if (gamecount > 4){
            gamecount = 0
            newshoe.initshoe(3)
        }
        
        wait = 0
    }
    
    func toDouble(str: String) -> Double? {
        var formatter = NSNumberFormatter()
        if let number = formatter.numberFromString(str) {
            return number.doubleValue
        }
        return nil
    }
    
    
    
}

