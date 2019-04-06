//
//  SecondViewController.swift
//  Motivator1
//
//  Created by Mathias Larsen on 20/02/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SecondViewController: UIViewController {
 
    var food = false
    var candy = false
    var soda = false
    var cigi = false
    var vape = false
    
    var ref = Database.database().reference()
    let formatter = DateFormatter()
    
    var reward = 50.0
    
    var user = User.user
    
    
    @IBOutlet weak var kcalInput: UITextField!
    
    
    @IBOutlet weak var messageLable: UILabel!
    
    @IBAction func foodButton(_ sender: UIButton) {
        if(sender.isSelected){
            sender.isSelected = false
            food = false
        }else{
            sender.isSelected = true
            food = true
        }
    }
    
    @IBAction func candyButton(_ sender: UIButton) {
        if(sender.isSelected){
            sender.isSelected = false
            candy = false
        }else{
            sender.isSelected = true
            candy = true
        }
    }
    
    
    @IBAction func sodaButton(_ sender: UIButton) {
        if(sender.isSelected){
            sender.isSelected = false
            soda = false
        }else{
            sender.isSelected = true
            soda = true
        }
    }
    
    @IBAction func cigiButton(_ sender: UIButton) {
        if(sender.isSelected){
            sender.isSelected = false
            cigi = false
        }else{
            sender.isSelected = true
            cigi = true
        }
    }
    
    @IBAction func vapeButton(_ sender: UIButton) {
        if(sender.isSelected){
            sender.isSelected = false
            vape = false
        }else{
            sender.isSelected = true
            vape = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "dd-MM-yyyy"

    }
    
    func saveXp(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        ref.child("users").child(uid).child("xp").child("totalXp").setValue(user.lvlSystem.xp)
        ref.child("users").child(uid).child("xp").child(formatter.string(from: Date())).setValue(user.lvlSystem.dalyXp)
    }

    @IBAction func submitButton(_ sender: Any) {
        var newXp = 0.0
        if(food){
            user.foodAchiveIncrument()
            newXp = newXp + 50
        }
        if(candy){
            user.candyAchiveIncrument()
            newXp = newXp + 50
        }
        if(soda){
            user.sodaAchiveIncrument()
            newXp = newXp + 50
        }
        if(cigi){
            user.cigiAchiveIncrument()
            newXp = newXp + 50
        }
        if(vape){
            user.vapeAchiveIncrument()
            newXp = newXp + 50
        }
        
        if let newKcalxp = Double(kcalInput.text!){
            newXp = newXp + newKcalxp
            user.lvlSystem.addXp(newXp: newKcalxp)
            if (formatter.string(from: Date()) == user.lvlSystem.date){
                user.lvlSystem.addDalyXp(newXp: newKcalxp)
            }else{
                user.lvlSystem.dalyXp = newKcalxp
                user.lvlSystem.date = formatter.string(from: Date())
            }
        }
        messageLable.text = "You gained \(newXp) xp"
        user.overKcalIncrumet()
        saveXp()
    }
    
}

