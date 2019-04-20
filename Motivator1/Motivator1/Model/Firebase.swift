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
    
    func saveXp(){
        formatter.dateFormat = "dd-MM-yyyy"
        guard let uid = Auth.auth().currentUser?.uid else {return}
        ref.child("users").child(uid).child("xp").child("totalXp").setValue(user.lvlSystem.xp)
        ref.child("users").child(uid).child("xp").child(formatter.string(from: Date())).setValue(user.lvlSystem.dalyXp)
    }
    
    func saveKcal(){
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).child("kcal").child("value").setValue(user.kcal.kcal)
        ref.child("users").child(uid!).child("kcal").child("date").setValue(user.kcal.date)
    }
    
    func saveAchivements(){
        for i in 0..<user.normAchiveArray.count{
            ref.child("users").child(uid!).child("achivements").child(user.normAchiveArray[i].name).child("days").setValue(user.normAchiveArray[i].days)
            ref.child("users").child(uid!).child("achivements").child(user.normAchiveArray[i].name).child("date").setValue(user.normAchiveArray[i].date)
        }
        
        for i in 0..<user.kcalAchiveArray.count{
            ref.child("users").child(uid!).child("achivements").child(user.kcalAchiveArray[i].name).child("days").setValue(user.kcalAchiveArray[i].days)
            ref.child("users").child(uid!).child("achivements").child(user.kcalAchiveArray[i].name).child("date").setValue(user.kcalAchiveArray[i].date)
        }
    }
    
    func getAchivments(){
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
    }
    
    
    func getXp(){
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).child("xp").child("totalXp").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            var value = snapshot.value as? Double
            
            //if the value does not excist in database create it and set to 0.0
            if value == nil {
                self.saveXp()
                value = 0.0
            }
            self.user.lvlSystem.xp = value!

        }) { (error) in
            print(error.localizedDescription)
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
            let value = snapshot.value as? String
            self.user.kcal.date = value!
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
