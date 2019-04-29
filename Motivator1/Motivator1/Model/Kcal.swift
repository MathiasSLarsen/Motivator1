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
    var newKcal = 0.0
    var date = "20-02-2019"

    func kcalDiff(newDate: String)-> Double{
        var kcalDiff = 0.0
        if !date.elementsEqual(newDate){
            kcalDiff = newKcal - kcal
            kcal = newKcal
            return kcalDiff
        }else{
            kcal = newKcal
            date = newDate
            return 0.0
        }
    }
}
