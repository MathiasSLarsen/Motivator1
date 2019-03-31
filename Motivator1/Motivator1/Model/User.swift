//
//  User.swift
//  Motivator1
//
//  Created by Mathias Larsen on 30/03/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation

class User {
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
    
    func User(){
    }
    
    
}
