//
//  Firebase.swift
//  Motivator1
//
//  Created by Mathias Larsen on 07/04/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct Firebase {
    
    static let firebase = Firebase()
    var ref = Database.database().reference()
    let formatter = DateFormatter()
    var user = User.user
    let uid = Auth.auth().currentUser?.uid
    
    
    
    
    func initUser(){
        
        let now = Date()
        let formater1 = DateFormatter()
        formater1.dateFormat = "dd-MM-yyyy"
        let formater2 = DateFormatter()
        formater2.dateFormat = "dd/MM"
        
        for i in (0...6).reversed(){
            let dateElement = formater2.calendar.date(byAdding: .day, value: -i, to: now)
            user.datesArray.append(formater2.string(from: dateElement!))
            print("\(formater2.string(from: dateElement!))")
            
            let uid = Auth.auth().currentUser?.uid
            let dateElement2 = formater1.calendar.date(byAdding: .day, value: -i, to: now)
            let dateString = formater1.string(from: dateElement2!)
            ref.child("users").child(uid!).child("xp").child("dailyxp").child(dateString).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                var value = snapshot.value as? Double
                
                //if the value does not excist in database set it to 0.0
                if value == nil {
                    value = 0.0
                }
                
                self.user.olddailyXpArray[i] = value!
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
        
        //getting achievements
        let uid = Auth.auth().currentUser?.uid
        for i in 0..<user.normAchiveArray.count{
            ref.child("users").child(uid!).child("achivements").child(user.normAchiveArray[i].name).child("days").observeSingleEvent(of: .value, with: {(snapshot) in
                var value = snapshot.value as? Int
                
                if value == nil{
                    self.saveAchivements()
                    value = 0
                }
                self.user.normAchiveArray[i].days = value!
            })
            ref.child("users").child(uid!).child("achivements").child(user.normAchiveArray[i].name).child("date").observeSingleEvent(of: .value, with: {(snapshot) in
                var value = snapshot.value as? String
                
                if value == nil{
                    self.saveAchivements()
                    value = "01-01-2019"
                }
                self.user.normAchiveArray[i].date = value!
            })
        }
        
        
        for i in 0..<user.kcalAchiveArray.count{
            ref.child("users").child(uid!).child("achivements").child(user.kcalAchiveArray[i].name).child("days").observeSingleEvent(of: .value, with: {(snapshot) in
                var value = snapshot.value as? Int
                
                if value == nil{
                    self.saveAchivements()
                    value = 0
                }
                self.user.kcalAchiveArray[i].days = value!
            })
            ref.child("users").child(uid!).child("achivements").child(user.kcalAchiveArray[i].name).child("date").observeSingleEvent(of: .value, with: {(snapshot) in
                var value = snapshot.value as? String
                
                if value == nil{
                    self.saveAchivements()
                    value = "01-01-2019"
                }
                self.user.kcalAchiveArray[i].date = value!
                
            })
        }
        print("done getting achievement")
        
        
        //getting xp
        formatter.dateFormat = "dd-MM-yyyy"
        ref.child("users").child(uid!).child("xp").child("totalXp").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            var value = snapshot.value as? Double
            
            //if the value does not excist in database create it and set to 0.0
            if value == nil {
                self.saveXp()
                value = 0.0
            }
            self.user.lvlSystem.xp = value!
            print("xp from db is \(value!)")
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        ref.child("users").child(uid!).child("xp").child("dailyxp").child(formatter.string(from: Date())).observeSingleEvent(of: .value) { (snapshot) in
            var value = snapshot.value as? Double
            if value == nil{
                self.saveXp()
                value = 0.0
            }
            self.user.lvlSystem.dalyXp = value!
        }
        
        //getting cigaretts
        formatter.dateFormat = "dd-MM-yyyy"
        ref.child("users").child(uid!).child("cigaret").child(formatter.string(from: Date())).observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                let houre = snap.value as! String
                let cigaret = Cigaret(date: self.formatter.string(from: Date()), houre: houre)
                self.user.cigiArray.append(cigaret)
                print("cigeret hour is \(cigaret.houre)")
                
            }
        })
        
        //getting kcal
        ref.child("users").child(uid!).child("kcal").child("value").observeSingleEvent(of: .value, with: { (snapshot) in
            var value = snapshot.value as? Double
            
            if value == nil {
                self.saveKcal()
                value = 0.0
            }
            self.user.kcal.kcal = value!
        }) { (error) in
            print(error.localizedDescription)
        }
        
        ref.child("users").child(uid!).child("kcal").child("date").observeSingleEvent(of: .value, with: { (snapshot) in
            var value = snapshot.value as? String
            if value == nil{
                self.saveKcal()
                value = "01-01-2019"
            }
            self.user.kcal.date = value!
            print("kcal from db is \(value!)")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: userSetNotification), object: self)
        }) { (error) in
            print(error.localizedDescription)
        }
        //user.datesArray.reverse()
        //getAchivments()
        //getXp()
        //getCigarets()
        //getKcal()
    }

    
    
    func saveCigaret(cigaret: Cigaret){
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).child("cigaret").child(cigaret.date).childByAutoId().setValue(cigaret.houre)
    }
    
    func saveXp(){
        let uid = Auth.auth().currentUser?.uid
        formatter.dateFormat = "dd-MM-yyyy"
        ref.child("users").child(uid!).child("xp").child("totalXp").setValue(user.lvlSystem.xp)
        ref.child("users").child(uid!).child("xp").child("dailyxp").child(formatter.string(from: Date())).setValue(user.lvlSystem.dalyXp)
    }
    
    func saveKcal(){
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).child("kcal").child("value").setValue(user.kcal.kcal)
        ref.child("users").child(uid!).child("kcal").child("date").setValue(user.kcal.date)
    }
    
    func saveDBUserId(){
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).child("dbUserId").setValue(user.dbId)
    }
    
    func saveAchivements(){
        let uid = Auth.auth().currentUser?.uid
        for i in 0..<user.normAchiveArray.count{
            ref.child("users").child(uid!).child("achivements").child(user.normAchiveArray[i].name).child("days").setValue(user.normAchiveArray[i].days)
            ref.child("users").child(uid!).child("achivements").child(user.normAchiveArray[i].name).child("date").setValue(user.normAchiveArray[i].date)
        }
        
        for i in 0..<user.kcalAchiveArray.count{
            ref.child("users").child(uid!).child("achivements").child(user.kcalAchiveArray[i].name).child("days").setValue(user.kcalAchiveArray[i].days)
            ref.child("users").child(uid!).child("achivements").child(user.kcalAchiveArray[i].name).child("date").setValue(user.kcalAchiveArray[i].date)
        }
    }
    
    func getDBUserId(){
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).child("DBUserId").observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? Int
            self.user.dbId = value!
        }
    }
    
    func getCigarets(){
        let uid = Auth.auth().currentUser?.uid
        formatter.dateFormat = "dd-MM-yyyy"
        ref.child("users").child(uid!).child("cigaret").child(formatter.string(from: Date())).observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                let houre = snap.value as! String
                let cigaret = Cigaret(date: self.formatter.string(from: Date()), houre: houre)
                self.user.cigiArray.append(cigaret)
                print("cigeret hour is \(cigaret.houre)")
                
            }
        })
    }
    func getAchivments(){
        let uid = Auth.auth().currentUser?.uid
        for i in 0..<user.normAchiveArray.count{
            ref.child("users").child(uid!).child("achivements").child(user.normAchiveArray[i].name).child("days").observeSingleEvent(of: .value, with: {(snapshot) in
                var value = snapshot.value as? Int
                
                if value == nil{
                    self.saveAchivements()
                    value = 0
                }
                self.user.normAchiveArray[i].days = value!
            })
            ref.child("users").child(uid!).child("achivements").child(user.normAchiveArray[i].name).child("date").observeSingleEvent(of: .value, with: {(snapshot) in
                var value = snapshot.value as? String
                
                if value == nil{
                    self.saveAchivements()
                    value = "01-01-2019"
                }
                self.user.normAchiveArray[i].date = value!
            })
        }
        
        let controle = user.kcalAchiveArray.count-1
        for i in 0..<user.kcalAchiveArray.count{
            ref.child("users").child(uid!).child("achivements").child(user.kcalAchiveArray[i].name).child("days").observeSingleEvent(of: .value, with: {(snapshot) in
                var value = snapshot.value as? Int
                
                if value == nil{
                    self.saveAchivements()
                    value = 0
                }
                self.user.kcalAchiveArray[i].days = value!
            })
            ref.child("users").child(uid!).child("achivements").child(user.kcalAchiveArray[i].name).child("date").observeSingleEvent(of: .value, with: {(snapshot) in
                var value = snapshot.value as? String
                
                if value == nil{
                    self.saveAchivements()
                    value = "01-01-2019"
                }
                self.user.kcalAchiveArray[i].date = value!
                
                if i == controle {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: userSetNotification), object: self)
                }
            })
        }
        print("done getting achievement")
        
    }
    
    
    func getXp(){
        let uid = Auth.auth().currentUser?.uid
        formatter.dateFormat = "dd-MM-yyyy"
        ref.child("users").child(uid!).child("xp").child("totalXp").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            var value = snapshot.value as? Double
            
            //if the value does not excist in database create it and set to 0.0
            if value == nil {
                self.saveXp()
                value = 0.0
            }
            self.user.lvlSystem.xp = value!
            print("xp from db is \(value!)")

        }) { (error) in
            print(error.localizedDescription)
        }
        
        ref.child("users").child(uid!).child("xp").child("dailyxp").child(formatter.string(from: Date())).observeSingleEvent(of: .value) { (snapshot) in
            var value = snapshot.value as? Double
            if value == nil{
                self.saveXp()
                value = 0.0
            }
            self.user.lvlSystem.dalyXp = value!
        }
 
    }
    
    func getKcal(){
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).child("kcal").child("value").observeSingleEvent(of: .value, with: { (snapshot) in
            var value = snapshot.value as? Double
            
            if value == nil {
                self.saveKcal()
                value = 0.0
            }
            self.user.kcal.kcal = value!
        }) { (error) in
            print(error.localizedDescription)
        }
        
        ref.child("users").child(uid!).child("kcal").child("date").observeSingleEvent(of: .value, with: { (snapshot) in
            var value = snapshot.value as? String
            if value == nil{
                self.saveKcal()
                value = "01-01-2019"
            }
            self.user.kcal.date = value!
            print("kcal from db is \(value!)")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
