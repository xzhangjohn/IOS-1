//
//  ViewController2.swift
//  BlackJack
//
//  Created by Xiao Zhang on 2/28/15.
//  Copyright (c) 2015 XiaoZhang. All rights reserved.
//

import UIKit
import Foundation

class ViewController2: UIViewController{
    @IBOutlet weak var inputdeck: UITextField!
    @IBOutlet weak var splayer: UIButton!
    @IBOutlet weak var tplayer: UIButton!
    var numDeck: Int = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func oplayerclick(sender: AnyObject) {
        var decknum = inputdeck.text.toInt()
        if (inputdeck.text == ""){
            decknum = 3
        }else{
            if (toDouble(inputdeck.text) == nil){
                let alertController = UIAlertController(title: "Warning", message: "Error input", preferredStyle:UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
        }
        if (decknum < 1){
            let alertController = UIAlertController(title: "Warning", message: "Error input", preferredStyle:UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        self.numDeck = decknum!
        
        self.performSegueWithIdentifier("btn2", sender: self)
    }
    
    @IBAction func tplayerclick(sender: AnyObject) {
        var decknum = inputdeck.text.toInt()
        if (inputdeck.text == ""){
            decknum = 3
        }else{
            if (toDouble(inputdeck.text) == nil){
                let alertController = UIAlertController(title: "Warning", message: "Error input", preferredStyle:UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
        }
        if (decknum < 1){
            let alertController = UIAlertController(title: "Warning", message: "Error input", preferredStyle:UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        self.numDeck = decknum!
        
        self.performSegueWithIdentifier("btn", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "btn"{
            var obj = segue.destinationViewController as ViewController
            obj.numDeck = self.numDeck
        }
        if segue.identifier == "btn2"{
            var obj = segue.destinationViewController as ViewController3
            obj.numDeck = self.numDeck
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