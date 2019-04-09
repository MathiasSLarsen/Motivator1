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
    var reward = 50.0
    var kcal = 0.0
    
    let formatter = DateFormatter()
    
    var normAchiveArray = [NormAchivement]()
    var kcalAchiveArray = [KcalAchivement]()
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
    
    let toDay = Date()
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
    
    mutating func fillArray(){
        normAchiveArray.append(foodAchiv)
        normAchiveArray.append(candyAchive)
        normAchiveArray.append(sodaAchive)
        normAchiveArray.append(cigiAchive)
        normAchiveArray.append(vapeAchive)
        kcalAchiveArray.append(over100Achive)
        kcalAchiveArray.append(over200Achive)
        kcalAchiveArray.append(over300Achive)
        kcalAchiveArray.append(over400Achvie)
        kcalAchiveArray.append(over500Achive)
    }
    
    func overKcalIncrumet(){
        formatter.dateFormat = "dd-MM-yyyy"

        if(kcal > 100 && !over100Achive.date.elementsEqual(formatter.string(from: toDay))){
            over100Achive.days = over100Achive.days + 1
            over100Achive.date = formatter.string(from: toDay)
            if(over100Achive.Achived()){
                lvlSystem.addDalyXp(newXp: over100Achive.Reward())
            }
        print("over 100 days = \(over100Achive.days)")
        }
    
        if(kcal > 200 && !over200Achive.date.elementsEqual(formatter.string(from: toDay))){
            over200Achive.days = over200Achive.days + 1
            over200Achive.date = formatter.string(from: toDay)
            if(over200Achive.Achived()){
                lvlSystem.addDalyXp(newXp: over200Achive.Reward())
            }
            print("over 200 days = \(over200Achive.days)")
        }
        
        if(kcal > 300 && !over300Achive.date.elementsEqual(formatter.string(from: toDay))){
            over300Achive.days = over300Achive.days + 1
            over300Achive.date = formatter.string(from: toDay)
            if(over300Achive.Achived()){
                lvlSystem.addDalyXp(newXp: over300Achive.Reward())
            }
            print("over 300 days = \(over300Achive.days)")
        }
        
        if(kcal > 400 && !over400Achvie.date.elementsEqual(formatter.string(from: toDay))){
            over400Achvie.days = over400Achvie.days + 1
            over400Achvie.date = formatter.string(from: toDay)
            if(over400Achvie.Achived()){
                lvlSystem.addDalyXp(newXp: over400Achvie.Reward())
            }
            print("over 400 days = \(over400Achvie.days)")
        }
        
        if(kcal > 500 && !over500Achive.date.elementsEqual(formatter.string(from: toDay))){
            over500Achive.days = over500Achive.days + 1
            over500Achive.date = formatter.string(from: toDay)
            if(over500Achive.Achived()){
                lvlSystem.addDalyXp(newXp: over500Achive.Reward())
            }
            print("over 500 days = \(over500Achive.days)")
        }
    }
    
    func foodAchiveIncrument() -> Double{
        if(!foodAchiv.date.elementsEqual(formatter.string(from: toDay)) ){
            foodAchiv.date = formatter.string(from: toDay)
            foodAchiv.days = foodAchiv.days + 1
            print(lvlSystem.xp)
            lvlSystem.addDalyXp(newXp: reward)
            print(lvlSystem.xp)
            return reward
        }
        return 0.0
    }
    
    func candyAchiveIncrument() -> Double{
        print(candyAchive.days)
        if(!candyAchive.date.elementsEqual(formatter.string(from: toDay)) ){
            candyAchive.date = formatter.string(from: toDay)
            candyAchive.days = candyAchive.days + 1
            lvlSystem.addDalyXp(newXp: reward)
            print(candyAchive.days)
            return reward
        }
        return 0.0
    }
    
    func sodaAchiveIncrument() -> Double{
        if(!sodaAchive.date.elementsEqual(formatter.string(from: toDay)) ){
            sodaAchive.date = formatter.string(from: toDay)
            sodaAchive.days = sodaAchive.days + 1
            lvlSystem.addDalyXp(newXp: reward)
            return reward
        }
        return 0.0
    }
    
    func cigiAchiveIncrument() -> Double{
        if(!cigiAchive.date.elementsEqual(formatter.string(from: toDay)) ){
            cigiAchive.date = formatter.string(from: toDay)
            cigiAchive.days = cigiAchive.days + 1
            lvlSystem.addDalyXp(newXp: reward)
            return reward
        }
        return 0.0
    }
    
    func vapeAchiveIncrument() -> Double{
        if(!vapeAchive.date.elementsEqual(formatter.string(from: toDay)) ){
            vapeAchive.date = formatter.string(from: toDay)
            vapeAchive.days = vapeAchive.days + 1
            lvlSystem.addDalyXp(newXp: reward)
            return reward
        }
        return 0.0
    }
    
    func foodAchiveDecrument() -> Double{
        foodAchiv.days = foodAchiv.days - 1
        foodAchiv.date = formatter.string(from: yesterday!)
        lvlSystem.addDalyXp(newXp: -reward)
        return -reward
    }
    
    func candyAchiveDecrument() -> Double{
        candyAchive.days = candyAchive.days - 1
        candyAchive.date = formatter.string(from: yesterday!)
        lvlSystem.addDalyXp(newXp: -reward)
        return -reward
    }
    
    func sodaAchiveDecrument() -> Double{
        sodaAchive.days = sodaAchive.days - 1
        sodaAchive.date = formatter.string(from: yesterday!)
        lvlSystem.addDalyXp(newXp: -reward)
        return -reward
    }
    
    func cigiAchiveDecrument() -> Double{
        cigiAchive.days = cigiAchive.days - 1
        cigiAchive.date = formatter.string(from: yesterday!)
        lvlSystem.addDalyXp(newXp: -reward)
        return -reward
    }
    
    func vapeAchiveDecrument() -> Double{
        vapeAchive.days = vapeAchive.days - 1
        vapeAchive.date = formatter.string(from: yesterday!)
        lvlSystem.addDalyXp(newXp: -reward)
        return -reward
    }
    
    mutating func checkDate(){
        formatter.dateFormat = "dd-MM-yyyy"
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: toDay)
        
        for i in 0...normAchiveArray.count-1{
            if(normAchiveArray[i].date.elementsEqual(formatter.string(from: yesterday!)) || normAchiveArray[i].date.elementsEqual(formatter.string(from: toDay))){
                print("day ok")
            }else{
                normAchiveArray[i].days = 0
                print("day not ok \(normAchiveArray[i].days) ")
            }
        }
        for i in 0...kcalAchiveArray.count-1{
            if(kcalAchiveArray[i].date.elementsEqual(formatter.string(from: yesterday!)) || kcalAchiveArray[i].date.elementsEqual(formatter.string(from: toDay))){
                print("day ok")
            }else{
                print("day not ok")
                kcalAchiveArray[i].days = 0
            }
        }
    }
    
    
}
