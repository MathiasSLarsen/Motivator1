//
//  FirstViewController.swift
//  Motivator1
//
//  Created by Mathias Larsen on 20/02/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import HealthKit

class FirstViewController: UIViewController {

    let healthKitStore:HKHealthStore = HKHealthStore()
    var user = User.user
    var firebase = Firebase.firebase
    let formatter = DateFormatter()
    var ref = Database.database().reference()
    
    @IBOutlet weak var Lvl: UILabel!
    @IBOutlet weak var XpRemaning: UILabel!
    @IBOutlet weak var XpInput: UITextField!
    @IBOutlet weak var ProgressBar: UIProgressView!
    @IBOutlet weak var autoKcalLable: UILabel!
    
    func authHealthKit(){
        let healtheKitTypsToRead: Set<HKObjectType> = [ HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!]
        
        let healthKitTypesToWrite: Set<HKSampleType> = []
        
        if !HKHealthStore.isHealthDataAvailable(){
            print("Error occured")
        }
        
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healtheKitTypsToRead){ (succes, error)-> Void in
            print("succes")
        }
    }
    
    func test() -> Double{
        var kcal = 0.0
        let calendar = Calendar.autoupdatingCurrent
        
        var dateComponents = calendar.dateComponents(
            [ .year, .month, .day ],
            from: Date()
        )
        
        // This line is required to make the whole thing work
        dateComponents.calendar = calendar
        
        let predicate = HKQuery.predicateForActivitySummary(with: dateComponents)
        
        let query = HKActivitySummaryQuery(predicate: predicate) { (query, summaries, error) in
            
            guard let summaries = summaries, summaries.count > 0
                else {
                    // No data returned. Perhaps check for error
                    print("no data")
                    return
            }
            
            // Handle the activity rings data here
            let energiUnit = HKUnit.kilocalorie()
            let summary = summaries.first
            kcal = (summary?.activeEnergyBurned.doubleValue(for: energiUnit))!
            print("kcal er = \(kcal)")
        }
        healthKitStore.execute(query)
        return kcal

    }
    func getAutoKcal()->Double{
        var kcal = 0.0
        let calender = Calendar.autoupdatingCurrent
        var dateComponents = calender.dateComponents([.year, .month, .day], from: Date())
        dateComponents.calendar = calender
        let predicate = HKQuery.predicateForSamples(withStart: Date(), end: Date(), options: .strictEndDate)
        
        let kcalType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        
        
        let query = HKSampleQuery(sampleType: kcalType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) {(query, results, error) in
            
            for i in 0...results!.count - 1 {
                if let result = results?[i] as? HKQuantitySample {
                    kcal = kcal + result.quantity.doubleValue(for: HKUnit.kilocalorie())
                    print("kcal = \(kcal)")
                }else{
                    print("fejl i for loop")
                }
            }
            DispatchQueue.main.async(execute: {() -> Void in
                self.autoKcalLable.text = "\(kcal)"
                
            })
            /*
            if let results = results?.last as? HKQuantitySample{
                
                print("kcal = \(results.quantity)")
                kcal = results.quantity.doubleValue(for: HKUnit.kilocalorie())
                DispatchQueue.main.async(execute: {() -> Void in
                    self.XpInput.text = "\(kcal)"
                    self.autoKcalLable.text = String(kcal)
                });
 
            }else{
                print("\(String(describing: results)), error = \(String(describing: error))")
            }
 */
        }
        healthKitStore.execute(query)
        return kcal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firebase.getXp()
        firebase.getAchivments()
        firebase.getKcal()
        formatter.dateFormat = "dd-MM-yyyy"
        user.fillArray()
        authHealthKit()
        self.autoKcalLable.text = String(self.getAutoKcal())
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000), execute: {
            self.setFields()
            self.user.checkDate()
        })
        
    }
    
    @IBAction func BarButton(_ sender: Any) {
        self.performSegue(withIdentifier: "GoBar", sender: nil)
    }
    
    func setFields(){
        print("total xp is \(user.lvlSystem.xp)")
        Lvl.text = "\(user.lvlSystem.getLvl())"
        XpRemaning.text = "\(user.lvlSystem.xpRemaningToNextLvl()) xp remaning for next lvl"
        ProgressBar.setProgress(Float(user.lvlSystem.progress()), animated: true)
        print("progress is \(user.lvlSystem.progress())")
        //animateCircle()
    }
    
    @IBAction func LogoutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        } catch let logoutError{
            print(logoutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let startPageVC = storyboard.instantiateViewController(withIdentifier: "StartPageViewController")
        self.present(startPageVC, animated: true, completion: nil)
    }
    
    
    @IBAction func SubmitButton(_ sender: Any) {
        
        if let newxp = Double(XpInput.text!){
            user.lvlSystem.addXp(newXp: newxp)
            if (formatter.string(from: Date()) == user.lvlSystem.date){
                user.lvlSystem.addDalyXp(newXp: newxp)
            }else{
                user.lvlSystem.dalyXp = newxp
                user.lvlSystem.date = formatter.string(from: Date())
            }
            firebase.saveXp()
            //animateCircle()
            setFields()
            user.overKcalIncrumet()
        }
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let Achivment = segue.destination as! AchivmentTableViewController
        Achivment.user = user
    }
 */

}

