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

let userSetNotification = "userSetNotification"
let userSetNotification2 = "userSetNotification2"

class FirstViewController: UIViewController {

    var user = User.user
    var healthKit = HealthKit.healthKit
    var rest = REST.rest
    var firebase = Firebase.firebase
    let formatter = DateFormatter()
    var ref = Database.database().reference()
    let dishcpachgroup = DispatchGroup()

    
    
    @IBOutlet weak var Lvl: UILabel!
    @IBOutlet weak var XpRemaning: UILabel!
    @IBOutlet weak var XpInput: UITextField!
    @IBOutlet weak var ProgressBar: UIProgressView!
    @IBOutlet weak var autoKcalLable: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.formatter.dateFormat = "dd-MM-yyyy"
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(userSetNotification), object: nil)
        firebase.getDBUserId()
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000), execute: {
            self.healthKit.authHealthKit()
            self.healthKit.getAutoKcal()
            self.rest.initUser(id: self.user.dbId)
            self.rest.lastSevenDailyxp()
        })
 */
        //user.fillArray()
        //firebase.getXp()
        //firebase.getAchivments()
        //firebase.getKcal()
        //healthKit.authHealthKit()
        //healthKit.getAutoKcal()
        
        
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000), execute: {
            self.user.lvlSystem.setLvl()
            self.user.lvlSystem.addDalyXp(newXp: self.user.kcal.kcalDiff(newDate: self.formatter.string(from: Date())))
            
            if self.user.lvlSystem.didLvlChange(){
                self.createLvlAlert()
            }
            self.setFields()
            for i in 0..<self.user.normAchiveArray.count{
                print("\(self.user.normAchiveArray[i].name) is used")
                self.user.normAchiveArray[i].checkDate()
            }
            for i in 0..<self.user.kcalAchiveArray.count{
                print("\(self.user.kcalAchiveArray[i].name) is used")
                self.user.kcalAchiveArray[i].checkDate()
                self.user.lvlSystem.addDalyXp(newXp: self.user.kcalAchiveArray[i].Incrumet(newkcal: self.user.kcal.kcal))
            }
            //self.firebase.saveAchivements()
            //self.firebase.saveKcal()
            //self.firebase.saveXp()
            self.rest.updateUser()
            
            for achieve in self.user.kcalAchiveArray{
                self.rest.updateKcalAchievement(achievement: achieve)
            }
        })
 */
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setFields()
    }
    
    @objc func loadData(){
        self.healthKit.authHealthKit()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setData), name: NSNotification.Name(userSetNotification2), object: nil)
        
        self.rest.initUser(id: self.user.dbId)
        self.rest.lastSevenDailyxp()
        self.healthKit.getAutoKcal()
        
    }
    
    @objc func setData(){
        formatter.dateFormat = "dd-MM-yyyy"
        self.user.lvlSystem.setLvl()
        print("dailyxp is \(user.lvlSystem.dalyXp)")
        self.user.lvlSystem.addDalyXp(newXp: self.user.kcal.kcalDiff(newDate: self.formatter.string(from: Date())))
        
        print("dailyxp is \(user.lvlSystem.dalyXp)")
        if self.user.lvlSystem.didLvlChange(){
            self.createLvlAlert()
        }
        self.setFields()
        for i in 0..<self.user.normAchiveArray.count{
            //print("\(self.user.normAchiveArray[i].name) is used")
            self.user.normAchiveArray[i].checkDate()
        }
        for i in 0..<self.user.kcalAchiveArray.count{
            //print("\(self.user.kcalAchiveArray[i].name) is used")
            self.user.kcalAchiveArray[i].checkDate()
            self.user.lvlSystem.addDalyXp(newXp: self.user.kcalAchiveArray[i].Incrumet(newkcal: self.user.kcal.kcal))
        }
        //self.firebase.saveAchivements()
        //self.firebase.saveKcal()
        //self.firebase.saveXp()
        self.rest.updateUser()
        rest.updateDailyXp()
        user.oldDailyXpArray[6] = user.lvlSystem.dalyXp
        
        for achieve in self.user.kcalAchiveArray{
            self.rest.updateKcalAchievement(achievement: achieve)
        }
    }
    
    func createLvlAlert(){
        let aleat = UIAlertController(title: "Level Up", message: "Congratulations you are now lvl \(user.lvlSystem.lvl)", preferredStyle: UIAlertController.Style.alert)
        
        aleat.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
        }))
        
        self.present(aleat, animated: true, completion: nil)
    }
    
    @IBAction func BarButton(_ sender: Any) {
        self.performSegue(withIdentifier: "GoBar", sender: nil)
    }
    
    func setFields(){
        OperationQueue.main.addOperation {
            print("total xp is \(self.user.lvlSystem.xp)")
            self.Lvl.text = "\(self.user.lvlSystem.lvl)"
            self.XpRemaning.text = "\(self.user.lvlSystem.xpRemaningToNextLvl()) xp remaning for next lvl"
            self.ProgressBar.setProgress(Float(self.user.lvlSystem.progress()), animated: true)
            print("progress is \(self.user.lvlSystem.progress())")
            self.autoKcalLable.text = "\(self.user.kcal.kcal) kcal has been added from health app"
        }
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
    
}

