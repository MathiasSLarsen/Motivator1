//
//  test.swift
//  Motivator1Tests
//
//  Created by Mathias Larsen on 03/05/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation
import XCTest

@testable import Motivator1

class test: XCTestCase{
   
    
    
    func testStartingValues(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let today = Date()
        let achieve = NormAchivement(name: "test")

        
        XCTAssertEqual(achieve.days, 0)
        XCTAssertNotEqual(achieve.date, formatter.string(from: today))
        XCTAssertEqual(achieve.reward, 50.0)
        XCTAssertEqual(achieve.daysArray, [0,3,5,7,10,14,20,30,45,60,80,110,150,200,365,1000])
    }
    
    func testPrevious(){
        let achieve = NormAchivement(name: "test")

        achieve.days = 4
        
        XCTAssertEqual(achieve.previous(), 3)
    }
    
    func testProgress(){
        let achieve = NormAchivement(name: "test")

        XCTAssertEqual(achieve.progress(), 0)
        
        achieve.days = 1
        
       XCTAssertEqual(achieve.progress(), 0.333, accuracy: 0.001)
    }
    
    func testNext(){
        let achieve = NormAchivement(name: "test")
        
        XCTAssertEqual(achieve.Next(), 3)
        
        achieve.days = 4
        XCTAssertEqual(achieve.Next(), 5)
    }
    
    func testReward(){
        let achieve = NormAchivement(name: "test")

        achieve.days = 3
        XCTAssertEqual(achieve.Reward(), 450.0)
    }
    
    func testAchived(){
        let achieve = NormAchivement(name: "test")

        XCTAssertEqual(achieve.Achived(), 0.0)
        
        achieve.days = 3
        
        XCTAssertEqual(achieve.Achived(), 450.0)
    }
    
    func testIncrument(){
        let achieve = NormAchivement(name: "test")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        
        XCTAssertEqual(achieve.days, 0)
        
        XCTAssertNotEqual(achieve.date, formatter.string(from: today))
        
        XCTAssertEqual(achieve.Incrument(), 50.0)
        XCTAssertEqual(achieve.days, 1)
        XCTAssertEqual(achieve.date, formatter.string(from: today))
        
        achieve.days = 2
        achieve.date = formatter.string(from: yesterday!)
        
        XCTAssertEqual(achieve.Incrument(), 500.0)
        
    }
    
    func testDecrument(){
        let achieve = NormAchivement(name: "test")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        
        achieve.days = 1
        achieve.date = formatter.string(from: today)
        
        XCTAssertEqual(achieve.Decrument(), -50.0)
        XCTAssertEqual(achieve.date, formatter.string(from: yesterday!))
        XCTAssertEqual(achieve.days, 0)
    }
    
    func testCheckDate(){
        let achieve = NormAchivement(name: "test")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let today = Date()
        let past = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        
        achieve.date = formatter.string(from: today)
        achieve.days = 1
        
        achieve.checkDate()
        XCTAssertEqual(achieve.date, formatter.string(from: today))
        XCTAssertEqual(achieve.days, 1)
        
        achieve.date = formatter.string(from: past!)
        
        achieve.checkDate()
        XCTAssertEqual(achieve.days, 0)
        
    }
}
