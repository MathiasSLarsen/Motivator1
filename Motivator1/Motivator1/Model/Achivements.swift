//
//  Achivements.swift
//  Motivator1
//
//  Created by Mathias Larsen on 28/03/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation

protocol Achivements {
    var date: String { get set }
    var days: Int {get set}
    
    func Next() ->Int
    func Reward() ->Double
    func Achived() ->Double
    func previous() ->Int
    func progress() ->Float
    
}
