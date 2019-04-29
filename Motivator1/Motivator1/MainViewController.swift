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
    let userSetNotification3 = "userSetNotification3"

class FirstViewController: UIViewController {

    var user = User.user
    var healthKit = HealthKit.healthKit
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: userSetNotification), object: nil)
        // Do any additional setup after loading the view, typically from a nib.
        self.formatter.dateFormat = "dd-MM-yyyy"
   
            self.user.fillArray()
            self.firebase.getXp()
            self.healthKit.authHealthKit()
            self.healthKit.getAutoKcal()
       
         NotificationCenter.default.addObserver(self, selector: #selector(updateAchievements), name: NSNotification.Name(rawValue: userSetNotification3), object: nil)
            self.firebase.getAchivments()
        
         NotificationCenter.default.addObserver(self, selector: #selector(updateKcal), name: NSNotification.Name(rawValue: userSetNotification2), object: nil)
            self.firebase.getKcal()
        

    }
    
    @objc func updateAchievements(){
        print("using achievements")
        for i in 0..<self.user.normAchiveArray.count{
            self.user.normAchiveArray[i].checkDate()
        }
        for i in 0..<self.user.kcalAchiveArray.count{
            self.user.kcalAchiveArray[i].checkDate()
            self.user.lvlSystem.addDalyXp(newXp: self.user.kcalAchiveArray[i].Incrumet(newkcal: self.user.kcal.kcal))
        }
        
        self.firebase.saveAchivements()
    }
    
    @objc func updateKcal(){
        
        self.user.lvlSystem.addDalyXp(newXp: self.user.kcal.kcalDiff(newDate: self.formatter.string(from: Date())))
        
        if self.user.lvlSystem.didLvlChange(){
            self.createLvlAlert()
        }
        
        setFields()
        
        
        self.firebase.saveKcal()
        self.firebase.saveXp()
    }
    
    @objc func updateUI() {
        self.user.lvlSystem.setLvl()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewWillAppear")
        setFields()
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
        OperationQueue.main.addOperation(){
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

