//
//  KcalAchivement.swift
//  Motivator1
//
//  Created by Mathias Larsen on 30/03/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation

class KcalAchivement {
    let daysArray = [0,2,4,6,9,13,17,25,31,46,65,85,115,155,230,300,900]
    var days = 0
    var kcal: Int
    
    init(kcal: Int) {
        self.kcal = kcal
    }
    
    func previous() -> Int {
        var previous = 0
        for i in 0 ..< daysArray.count{
            if (daysArray[i] > days){
                previous = daysArray[i-1]
                break
            }
        }
        return previous
    }
    
    func progress() -> Float {
        let top = Float(days)
        let buttom = Float(Next())
        let progress = Float(top/buttom)
        print("\(progress) days = \(days) next = \(Next())")
        return progress
    }
    
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
        return Double(days) * Double(days) * Double(kcal)
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
