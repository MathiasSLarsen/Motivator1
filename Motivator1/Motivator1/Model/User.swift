//
//  User.swift
//  Motivator1
//
//  Created by Mathias Larsen on 30/03/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation

struct User {
    
    static let user = User()
    var username = ""
    
    let lvlSystem = LvlSystem()
    
    let foodAchiv = NormAchivement()
    let candyAchive = NormAchivement()
    let sodaAchive = NormAchivement()
    let cigiAchive = NormAchivement()
    let vapeAchive = NormAchivement()
    
    let over100Achive = KcalAchivement(kcal: 100)
    let over200Achive = KcalAchivement(kcal: 200)
    let over300Achive = KcalAchivement(kcal: 300)
    let over400Achvie = KcalAchivement(kcal: 400)
    let over500Achive = KcalAchivement(kcal: 500)
    
    func overKcalIncrumet(){
        if(lvlSystem.dalyXp > 100){
            over100Achive.days = over100Achive.days + 1
            if(over100Achive.Achived()){
                lvlSystem.addDalyXp(newXp: over100Achive.Reward())
            }
        print("over 100 days = \(over100Achive.days)")
        }
    
        if(lvlSystem.dalyXp > 200){
            over200Achive.days = over200Achive.days + 1
            if(over200Achive.Achived()){
                lvlSystem.addDalyXp(newXp: over200Achive.Reward())
            }
            print("over 200 days = \(over200Achive.days)")
        }
        
        if(lvlSystem.dalyXp > 300){
            over300Achive.days = over300Achive.days + 1
            if(over300Achive.Achived()){
                lvlSystem.addDalyXp(newXp: over300Achive.Reward())
            }
            print("over 300 days = \(over300Achive.days)")
        }
        
        if(lvlSystem.dalyXp > 400){
            over400Achvie.days = over400Achvie.days + 1
            if(over400Achvie.Achived()){
                lvlSystem.addDalyXp(newXp: over400Achvie.Reward())
            }
            print("over 400 days = \(over400Achvie.days)")
        }
        
        if(lvlSystem.dalyXp > 500){
            over500Achive.days = over500Achive.days + 1
            if(over500Achive.Achived()){
                lvlSystem.addDalyXp(newXp: over500Achive.Reward())
            }
            print("over 500 days = \(over500Achive.days)")
        }
    }
}
