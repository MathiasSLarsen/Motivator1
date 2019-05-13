//
//  User.swift
//  Motivator1
//
//  Created by Mathias Larsen on 30/03/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation

class User {
    
    static let user = User()
    var dbId = 0
    let reward = 50.0
    var userName = ""
    /*
    struct OldDailyXp {
        let dailyXp: Double
        let date: String
    }
    */
    
    let formatter = DateFormatter()
    
    var oldDailyXpArray = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    var cigiArray = [Cigaret]()
    var normAchiveArray = [NormAchivement]()
    var kcalAchiveArray = [KcalAchivement]()
    let lvlSystem = LvlSystem()
    let kcal = Kcal()
    
    let foodAchiv = NormAchivement(name: "food")
    let candyAchive = NormAchivement(name: "candy")
    let sodaAchive = NormAchivement(name: "soda")
    let cigiAchive = NormAchivement(name: "cigi")
    let vapeAchive = NormAchivement(name: "vape")
    
    let over100Achive = KcalAchivement(kcal: 100, name: "over100")
    let over200Achive = KcalAchivement(kcal: 200, name: "over200")
    let over300Achive = KcalAchivement(kcal: 300, name: "over300")
    let over400Achvie = KcalAchivement(kcal: 400, name: "over400")
    let over500Achive = KcalAchivement(kcal: 500, name: "over500")
    
    let toDay = Date()
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
    
    func fillArray(){
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

   /*
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
 */
    
    
}
