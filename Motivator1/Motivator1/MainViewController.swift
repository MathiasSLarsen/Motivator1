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

    var user = User.user
    var healthKit = HealthKit.healthKit
    var firebase = Firebase.firebase
    let formatter = DateFormatter()
    var ref = Database.database().reference()
    
    @IBOutlet weak var Lvl: UILabel!
    @IBOutlet weak var XpRemaning: UILabel!
    @IBOutlet weak var XpInput: UITextField!
    @IBOutlet weak var ProgressBar: UIProgressView!
    @IBOutlet weak var autoKcalLable: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firebase.getXp()
        firebase.getAchivments()
        firebase.getKcal()
        formatter.dateFormat = "dd-MM-yyyy"
        user.fillArray()
        healthKit.authHealthKit()
        healthKit.getAutoKcal()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000), execute: {
            self.user.lvlSystem.setLvl()
            self.user.lvlSystem.addDalyXp(newXp: self.user.kcal.kcalDiff(newDate: self.formatter.string(from: Date())))
            
            if self.user.lvlSystem.didLvlChange(){
                self.createLvlAlert()
            }
            self.setFields()
            self.user.checkDate()
            self.user.overKcalIncrumet()
            self.firebase.saveKcal()
            self.firebase.saveXp()
            
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        print("total xp is \(user.lvlSystem.xp)")
        Lvl.text = "\(user.lvlSystem.lvl)"
        XpRemaning.text = "\(user.lvlSystem.xpRemaningToNextLvl()) xp remaning for next lvl"
        ProgressBar.setProgress(Float(user.lvlSystem.progress()), animated: true)
        print("progress is \(user.lvlSystem.progress())")
        autoKcalLable.text = "\(user.kcal.kcal) kcal has been added from health app"
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

