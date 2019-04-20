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
    let reward = 50.0
    let toDay = Date()
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
    let formatter = DateFormatter()
    let name: String
    
    init(name: String){
        self.name = name
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
        return Double(days) * Double(days) * 50.0
    }
    
    func Achived() -> Double {
        for i in 0..<daysArray.count{
            if(daysArray[i] == days){
                return Reward()
            }
        }
        return 0.0
    }
    
    func Incrument() -> Double{
        formatter.dateFormat = "dd-MM-yyyy"
        if(!date.elementsEqual(formatter.string(from: toDay)) ){
            date = formatter.string(from: toDay)
            days = days + 1
            return reward + Achived()
        }
        return 0.0
    }
    
    func Decrument() -> Double{
        let temp = Achived()
        days = days - 1
        date = formatter.string(from: yesterday!)
        return -reward - temp
    }
    
    func checkDate(){
        formatter.dateFormat = "dd-MM-yyyy"
        
        if(date.elementsEqual(formatter.string(from: yesterday!)) || date.elementsEqual(formatter.string(from: toDay))){
                print("day ok")
        }else{
            days = 0
            print("day not ok \(days) ")
        }
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
