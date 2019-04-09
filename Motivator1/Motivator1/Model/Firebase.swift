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
    
    func saveXp(){
        formatter.dateFormat = "dd-MM-yyyy"
        guard let uid = Auth.auth().currentUser?.uid else {return}
        ref.child("users").child(uid).child("xp").child("totalXp").setValue(user.lvlSystem.xp)
        ref.child("users").child(uid).child("xp").child(formatter.string(from: Date())).setValue(user.lvlSystem.dalyXp)
    }
    
    func saveAchivements(){
        formatter.dateFormat = "dd-MM-yyyy"
        let uid = Auth.auth().currentUser?.uid
        
    ref.child("users").child(uid!).child("achivements").child("food").child("days").setValue(user.foodAchiv.days)
    ref.child("users").child(uid!).child("achivements").child("food").child("date").setValue(user.foodAchiv.date)
        
    ref.child("users").child(uid!).child("achivements").child("soda").child("days").setValue(user.sodaAchive.days)
    ref.child("users").child(uid!).child("achivements").child("soda").child("date").setValue(user.sodaAchive.date)
        
    ref.child("users").child(uid!).child("achivements").child("candy").child("days").setValue(user.candyAchive.days)
    ref.child("users").child(uid!).child("achivements").child("candy").child("date").setValue(user.candyAchive.date)
        
    ref.child("users").child(uid!).child("achivements").child("cigi").child("days").setValue(user.cigiAchive.days)
    ref.child("users").child(uid!).child("achivements").child("cigi").child("date").setValue(user.cigiAchive.date)
        
    ref.child("users").child(uid!).child("achivements").child("vape").child("days").setValue(user.vapeAchive.days)
    ref.child("users").child(uid!).child("achivements").child("vape").child("date").setValue(user.vapeAchive.date)
        
    ref.child("users").child(uid!).child("achivements").child("over100").child("days").setValue(user.over100Achive.days)
    ref.child("users").child(uid!).child("achivements").child("over100").child("date").setValue(user.over100Achive.date)
        
    ref.child("users").child(uid!).child("achivements").child("over200").child("days").setValue(user.over200Achive.days)
    ref.child("users").child(uid!).child("achivements").child("over200").child("date").setValue(user.over200Achive.date)
        
    ref.child("users").child(uid!).child("achivements").child("over300").child("days").setValue(user.over300Achive.days)
    ref.child("users").child(uid!).child("achivements").child("over300").child("date").setValue(user.over300Achive.date)
        
    ref.child("users").child(uid!).child("achivements").child("over400").child("days").setValue(user.over400Achvie.days)
    ref.child("users").child(uid!).child("achivements").child("over400").child("date").setValue(user.over400Achvie.date)
        
    ref.child("users").child(uid!).child("achivements").child("over500").child("days").setValue(user.over500Achive.days)
    ref.child("users").child(uid!).child("achivements").child("over500").child("date").setValue(user.over500Achive.date)
    }
    
    func getAchivments(){
        let uid = Auth.auth().currentUser?.uid
        
    ref.child("users").child(uid!).child("achivements").child("food").child("days").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? Int
        
            if value == nil{
                self.saveAchivements()
            }
            self.user.foodAchiv.days = value!
        })
        ref.child("users").child(uid!).child("achivements").child("food").child("date").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? String
            self.user.foodAchiv.date = value!
        })
        ref.child("users").child(uid!).child("achivements").child("candy").child("days").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? Int
            self.user.candyAchive.days = value!
        })
        ref.child("users").child(uid!).child("achivements").child("candy").child("date").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? String
            self.user.candyAchive.date = value!
        })
        ref.child("users").child(uid!).child("achivements").child("soda").child("days").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? Int
            self.user.sodaAchive.days = value!
        })
        ref.child("users").child(uid!).child("achivements").child("soda").child("date").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? String
            self.user.sodaAchive.date = value!
        })
        
        ref.child("users").child(uid!).child("achivements").child("cigi").child("days").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? Int
            self.user.cigiAchive.days = value!
        })
        ref.child("users").child(uid!).child("achivements").child("cigi").child("date").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? String
            self.user.cigiAchive.date = value!
        })
        ref.child("users").child(uid!).child("achivements").child("vape").child("days").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? Int
            self.user.vapeAchive.days = value!
        })
        ref.child("users").child(uid!).child("achivements").child("vape").child("date").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? String
            self.user.vapeAchive.date = value!
        })
        ref.child("users").child(uid!).child("achivements").child("over100").child("days").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? Int
            self.user.over100Achive.days = value!
        })
        ref.child("users").child(uid!).child("achivements").child("over100").child("date").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? String
            self.user.over100Achive.date = value!
        })
        
        ref.child("users").child(uid!).child("achivements").child("over200").child("days").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? Int
            self.user.over200Achive.days = value!
        })
        ref.child("users").child(uid!).child("achivements").child("over200").child("date").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? String
            self.user.over200Achive.date = value!
        })
        
        ref.child("users").child(uid!).child("achivements").child("over300").child("days").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? Int
            self.user.over300Achive.days = value!
        })
        ref.child("users").child(uid!).child("achivements").child("over300").child("date").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? String
            self.user.over300Achive.date = value!
        })
        ref.child("users").child(uid!).child("achivements").child("over400").child("days").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? Int
            self.user.over400Achvie.days = value!
        })
        ref.child("users").child(uid!).child("achivements").child("over400").child("date").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? String
            self.user.over400Achvie.date = value!
        })
        
        ref.child("users").child(uid!).child("achivements").child("over500").child("days").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? Int
            self.user.over500Achive.days = value!
        })
        ref.child("users").child(uid!).child("achivements").child("over500").child("date").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? String
            self.user.over500Achive.date = value!
        })
        
    }
    
    
    func getXp(){
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).child("xp").child("totalXp").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            var value = snapshot.value as? Double
            
            //if the value does not excist in database create it and set to 0.0
            if value == nil {
                self.saveXp()
                //self.ref.child("users").child(uid!).child("xp").setValue(self.lvlSystem.xp)
                value = 0.0
            }
            self.user.lvlSystem.xp = value!
            
            OperationQueue.main.addOperation {
               // self.setFields()
            }
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
