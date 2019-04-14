//
//  Kcal.swift
//  Motivator1
//
//  Created by Mathias Larsen on 13/04/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation

class Kcal{
    var kcal = 0.0
    var date = "20-02-2019"

    func kcalDiff(newkcal: Double, newDate: String)-> Double{
        var kcalDiff = 0.0
        if date.elementsEqual(newDate){
            kcalDiff = newkcal - kcal
            kcal = newkcal
            return kcalDiff
        }else{
            kcal = newkcal
            date = newDate
            return kcal
        }
        
        
        return newkcal - kcal
        
    }
}
