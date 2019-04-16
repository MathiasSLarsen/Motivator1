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
    
    var checkBox = UIImage(named: "checked-checkbox")
    var unCheckBox = UIImage(named: "unchecked-checkbox")
    
    let formatter = DateFormatter()
    let toDay = Date()
    
    var user = User.user
    var firebase = Firebase.firebase
    var healthKit = HealthKit.healthKit
    
    
    @IBOutlet weak var kcalInput: UITextField!
    
    @IBOutlet weak var foodBox: UIButton!
    
    @IBOutlet weak var candyBox: UIButton!
    
    @IBOutlet weak var sodaBox: UIButton!
    
    @IBOutlet weak var cigiBox: UIButton!
    
    @IBOutlet weak var vapeBox: UIButton!
    
    
    @IBOutlet weak var messageLable: UILabel!
    
    @IBAction func foodButton(_ sender: UIButton) {
        if(food){
            foodBox.setImage(unCheckBox, for: .normal)
            food = false
        }else{
            foodBox.setImage(checkBox, for: .normal)
            food = true
        }
    }
    
    @IBAction func candyButton(_ sender: UIButton) {
        if(candy){
            candyBox.setImage(unCheckBox, for: .normal)
            candy = false
        }else{
            candyBox.setImage(checkBox, for: .normal)
            candy = true
        }
    }
    
    
    @IBAction func sodaButton(_ sender: UIButton) {
        if(soda){
            sodaBox.setImage(unCheckBox, for: .normal)
            soda = false
        }else{
            sodaBox.setImage(checkBox, for: .normal)
            soda = true
        }
    }
    
    @IBAction func cigiButton(_ sender: UIButton) {
        if(cigi){
            cigiBox.setImage(unCheckBox, for: .normal)
            cigi = false
        }else{
            cigiBox.setImage(checkBox, for: .normal)
            cigi = true
        }
    }
    
    @IBAction func vapeButton(_ sender: UIButton) {
        if(vape){
            vapeBox.setImage(unCheckBox, for: .normal)
            vape = false
        }else{
            vapeBox.setImage(checkBox, for: .normal)
            vape = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "dd-MM-yyyy"
        setFields()

    }
    
    func setFields(){
        if(user.foodAchiv.date == formatter.string(from: Date())){
            food = true
            foodBox.setImage(checkBox, for: .normal)
        }
        if(user.candyAchive.date == formatter.string(from: Date())){
            candy = true
            candyBox.setImage(checkBox, for: .normal)
        }
        if(user.sodaAchive.date == formatter.string(from: Date())){
            soda = true
            sodaBox.setImage(checkBox, for: .normal)
        }
        if(user.cigiAchive.date == formatter.string(from: Date())){
            cigi = true
            cigiBox.setImage(checkBox, for: .normal)
        }
        if(user.vapeAchive.date == formatter.string(from: Date())){
            vape = true
            vapeBox.setImage(checkBox, for: .normal)
        }
    }
    
    func createAlert(title: String, message: String){
        let aleat = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        aleat.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
        }))
        
        self.present(aleat, animated: true, completion: nil)
    }

    @IBAction func submitButton(_ sender: Any) {
        var newXp = 0.0
        let title = "Achievment Unlocked"
        
        if(food){
            newXp = newXp + user.foodAchiveIncrument()
            if user.foodAchiv.Achived() && !user.foodAchiv.rewardReceived{
                newXp = newXp + user.foodAchiv.Reward()
                user.foodAchiv.rewardReceived = true
                createAlert(title: title, message: "You have not eaten fast food for \(user.foodAchiv.days) days, your reward is \(user.foodAchiv.Reward())!")
            }
            if !user.foodAchiv.Achived(){
                user.foodAchiv.rewardReceived = false
            }
        }else if(!food && user.foodAchiv.date.elementsEqual(formatter.string(from: toDay))){
            newXp = newXp + user.foodAchiveDecrument()
        }
        
        if(candy){
            newXp = newXp + user.candyAchiveIncrument()
            if user.candyAchive.Achived() && !user.candyAchive.rewardReceived{
                newXp = newXp + user.candyAchive.Reward()
                user.candyAchive.rewardReceived = true
                createAlert(title: title, message: "You have not eaten candy for \(user.candyAchive.days) days, your reward is \(user.candyAchive.Reward())!")
            }
            if !user.candyAchive.Achived(){
                user.candyAchive.rewardReceived = false
            }
        }else if (!candy && user.candyAchive.date.elementsEqual(formatter.string(from: toDay))){
            newXp = newXp + user.candyAchiveDecrument()
        }
        
        if(soda){
            newXp = newXp + user.sodaAchiveIncrument()
            if user.sodaAchive.Achived() && !user.sodaAchive.rewardReceived{
                newXp = newXp + user.sodaAchive.Reward()
                user.sodaAchive.rewardReceived = true
                createAlert(title: title, message: "You did not drink soda for \(user.sodaAchive.days) days, you reward is \(user.sodaAchive.Reward())!")
            }
            if !user.sodaAchive.Achived(){
                user.sodaAchive.rewardReceived = false
            }
        }else if (!soda && user.sodaAchive.date.elementsEqual(formatter.string(from: toDay))){
            newXp = newXp + user.sodaAchiveDecrument()
        }
        
        if(cigi){
            newXp = newXp + user.cigiAchiveIncrument()
            if user.cigiAchive.Achived() && !user.cigiAchive.rewardReceived{
                newXp = newXp + user.cigiAchive.Reward()
                user.cigiAchive.rewardReceived = true
                createAlert(title: title, message: "You did not smoke cigarettes for \(user.cigiAchive.days) days, you reward is \(user.cigiAchive.Reward())!")
            }
            if !user.cigiAchive.Achived(){
                user.cigiAchive.rewardReceived = false
            }
        }else if (!cigi && user.cigiAchive.date.elementsEqual(formatter.string(from: toDay))){
            newXp = newXp + user.cigiAchiveDecrument()
        }
        
        if(vape){
            newXp = newXp + user.vapeAchiveIncrument()
            if user.vapeAchive.Achived() && !user.vapeAchive.rewardReceived{
                newXp = newXp + user.vapeAchive.Reward()
                user.vapeAchive.rewardReceived = true
                createAlert(title: title, message: "You did not vape for \(user.vapeAchive.days) days, your reward is \(user.vapeAchive.Reward())")
            }
            if !user.vapeAchive.Achived(){
                user.vapeAchive.rewardReceived = false
            }
        }else if (!vape && user.vapeAchive.date.elementsEqual(formatter.string(from: toDay))){
            newXp = newXp + user.vapeAchiveDecrument()
        }
        
        if let newKcalxp = Double(kcalInput.text!){
            newXp = newXp + newKcalxp
            user.kcal.kcal = user.kcal.kcal + newKcalxp
            healthKit.saveAutoKcal(newKcal: newKcalxp)
            if (formatter.string(from: Date()) == user.lvlSystem.date){
                user.lvlSystem.addDalyXp(newXp: newKcalxp)
            }else{
                user.lvlSystem.dalyXp = 0
                user.lvlSystem.addDalyXp(newXp: newKcalxp)
                user.lvlSystem.date = formatter.string(from: Date())
            }
            //indsæt code her
        }
        if user.lvlSystem.didLvlChange(){
            createAlert(title: "Lvl Up", message: "Congratulations you are now lvl \(user.lvlSystem.lvl)")
        }
        messageLable.text = "You gained \(newXp) xp"
        user.overKcalIncrumet()
        firebase.saveXp()
        firebase.saveAchivements()
        firebase.saveKcal()
    }
    
}

