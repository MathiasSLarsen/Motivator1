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

class FirstViewController: UIViewController {

   
    var user = User.user
    var firebase = Firebase.firebase
    //new shapelayer
    //let shapeLayer = CAShapeLayer()
    let formatter = DateFormatter()
    
    
    var ref = Database.database().reference()
    
    @IBOutlet weak var Lvl: UILabel!
    @IBOutlet weak var XpRemaning: UILabel!
    @IBOutlet weak var XpInput: UITextField!
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firebase.getXp()
        firebase.getAchivments()
        formatter.dateFormat = "dd-MM-yyyy"
        user.fillArray()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500), execute: {
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

