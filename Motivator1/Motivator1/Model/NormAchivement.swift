//
//  NormAchivement.swift
//  Motivator1
//
//  Created by Mathias Larsen on 28/03/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation

class NormAchivement: Achivements {
    let daysArray = [3,5,7,10,14,20,30,45,60,80,110,150,200,365,1000]
    var days = 0
    
    
    
    func Next() -> Int {
        var next = 0
        for i in 0 ..< daysArray.count{
            if (daysArray[i] > days){
                next = daysArray[i]
                break
            }
        }
        return next
    }
    
    func Reward() -> Double {
        return Double(days) * Double(days) * 50.0
    }
    
    func Achived() -> Bool {
        for i in 0..<daysArray.count{
            if(daysArray[i] == days){
                return true
            }
        }
        return false
    }
    
    
}
