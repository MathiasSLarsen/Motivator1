//
//  NormAchivement.swift
//  Motivator1
//
//  Created by Mathias Larsen on 28/03/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation

class NormAchivement: Achivements {
    
    
    let daysArray = [0,3,5,7,10,14,20,30,45,60,80,110,150,200,365,1000]
    var days = 0
    var date = "04-03-2019"
    var rewardReceived = false
    
    
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
    
    func getDate() -> String{
    return date
    }
    func setDate(date: String) {
        self.date = date
    }
    func getDays() -> Int{
        return days
    }
    func setDays(days: Int) {
        self.days = days
    }
    
    
}
