//
//  LvlSystem.swift
//  Motivator
//
//  Created by Mathias Larsen on 18/02/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation
import UIKit

class LvlSystem{
    
    var xp = 0.0
    var dalyXp = 0.0
    var date = "20-02-2019"
    var lvl = 0
    var newlvl = 0
    
    // xp=250+lvl^2*100
    // lvl=sqrt((xp-250)/100)
    
    
    //calculates the lvl based on xp
    func setLvl(){
        if xp < 250{
            lvl = 0
        }else{
            lvl = Int(sqrt((xp-250)/100))
        }
    }
    
    func didLvlChange()-> Bool{
        if xp < 250{
            return false
        }else{
            newlvl = Int(sqrt((xp-250)/100))
            if lvl != newlvl{
                lvl = newlvl
                return true
            }else{
                return false
            }
        }
    }
    
    //calculates the total amount of xp requered for lvl+1
    func xpForNextLvl()->Double{
        return 100.0*(Double)(lvl+1)*(Double)(lvl+1)+250.0
    }
    
    func xpForThisLvl()->Double{
        if lvl == 0{
            return 0.0
        }else
        {
        return 100.0*(Double)(lvl)*(Double)(lvl)+250.0
        }
    }
    
    func progress()->Double{
        let progress = xp - xpForThisLvl()
        let total = xpForNextLvl() - xpForThisLvl()
        
        return progress / total
    }
    
    //calculates how many xp you need to get to the next lvl
    func xpRemaningToNextLvl()->Double{
        return xpForNextLvl() - xp
    }
    
    func addXp(newXp: Double){
        xp = xp + newXp
    }
    
    func addDalyXp(newXp: Double){
        dalyXp = dalyXp + newXp
        addXp(newXp: newXp)
    }
    
}
