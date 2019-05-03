//
//  HealthKit.swift
//  Motivator1
//
//  Created by Mathias Larsen on 16/04/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation
import HealthKit


struct HealthKit {
    
    static let healthKit = HealthKit()
    let healthKitStore:HKHealthStore = HKHealthStore()
    let user = User.user
    
    func authHealthKit(){
        let healtheKitTypsToRead: Set<HKObjectType> = [ HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!]
        
        let healthKitTypesToWrite: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!]
        
        if !HKHealthStore.isHealthDataAvailable(){
            print("Error occured")
        }
        
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healtheKitTypsToRead){ (succes, error)-> Void in
            print("succes")
        }
    }
    
    func saveAutoKcal(newKcal: Double){
        if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned){
            
            let quantity = HKQuantity(unit: .kilocalorie(), doubleValue: newKcal)
            
            let sample = HKQuantitySample(type: type, quantity: quantity, start: Date(), end: Date())
            healthKitStore.save(sample, withCompletion: { (success, error) in
                print("saved \(success), error \(String(describing: error))")
            })
        }
    }
    
    func getAutoKcal(){
        var kcal = 0.0
        let calender = Calendar.current
        var dateComponents = calender.dateComponents([.year, .month, .day], from: Date())
        dateComponents.calendar = calender
        let yesterday = calender.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
        let predicate = HKQuery.predicateForSamples(withStart: yesterday, end: Date(), options: .strictEndDate)
        
        let kcalType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        
        
        let query = HKSampleQuery(sampleType: kcalType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) {(query, results, error) in
            if results == nil{
                
            }else{
                for i in 0..<results!.count {
                    if let result = results?[i] as? HKQuantitySample {
                        kcal = kcal + result.quantity.doubleValue(for: HKUnit.kilocalorie())
                        print("kcal = \(kcal)")
                    }else{
                        print("fejl i for loop")
                    }
                }
                DispatchQueue.main.async(execute: {() -> Void in
                    self.user.kcal.newKcal = kcal
                });
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: userSetNotification2), object: self)
            
        }
        healthKitStore.execute(query)
    }
}
