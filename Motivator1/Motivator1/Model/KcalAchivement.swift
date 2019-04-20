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
    var kcal: Double
    var date = "03-03-2019"
    let formatter = DateFormatter()
    let toDay = Date()
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
    let name: String
    
    init(kcal: Double, name: String) {
        self.kcal = kcal
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
        return Double(days) * Double(days) * Double(kcal)
    }
    
    func Achived() -> Double {
        for i in 0..<daysArray.count{
            if(daysArray[i] == days){
                return Reward()
            }
        }
        return 0.0
    }
    
    func Incrumet(newkcal: Double)-> Double{
        formatter.dateFormat = "dd-MM-yyyy"
        
        if(newkcal > kcal && !date.elementsEqual(formatter.string(from: toDay))){
            days = days + 1
            date = formatter.string(from: toDay)
            return Achived()
        }else{
            return 0.0
        }
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
