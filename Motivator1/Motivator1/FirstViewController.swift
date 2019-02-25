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

    var lvlSystem = LvlSystem()
    //new shapelayer
    let shapeLayer = CAShapeLayer()
    
    var ref = Database.database().reference()
    
    @IBOutlet weak var Lvl: UILabel!
    
    @IBOutlet weak var XpRemaning: UILabel!
    
    @IBOutlet weak var XpInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getXp()
        print("getXp shuld have run \(lvlSystem.xp)")
        setFields()
        
    }
    
    func setFields(){
        print("total xp is \(lvlSystem.xp)")
        Lvl.text = "\(lvlSystem.getLvl())"
        XpRemaning.text = "\(lvlSystem.xpRemaningToNextLvl()) xp remaning for next lvl"
        
        animateCircle()
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
            lvlSystem.addXp(newXp: newxp)
            saveXp()
            //animateCircle()
            setFields()
        }
    }

        func animateCircle(){
            //circle progressbar
            
            //set center of the circle
            let center = CGPoint(x: view.center.x, y: 250)
            
            //create track layer
            let trackLayer = CAShapeLayer()
            let circularPath = UIBezierPath(arcCenter: center, radius: 150, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
            
            trackLayer.path = circularPath.cgPath
            //set color of the ring around the circle
            trackLayer.strokeColor = UIColor.lightGray.cgColor
            //set the width of the ring around the circle
            trackLayer.lineWidth = 10
            trackLayer.lineCap = .round
            trackLayer.fillColor = UIColor.clear.cgColor
            view.layer.addSublayer(trackLayer)
            
            let progress = CGFloat(lvlSystem.xp - lvlSystem.xpForThisLvl(lvl: lvlSystem.getLvl()))
            let total = CGFloat(lvlSystem.xpForNextLvl(lvl: lvlSystem.getLvl()) - lvlSystem.xpForThisLvl(lvl: lvlSystem.getLvl()))
            
            let test = CGFloat( -CGFloat.pi/2 + (progress / total * 2 * CGFloat.pi))
            //define the path
            let progressPath = UIBezierPath(arcCenter: center, radius: 150, startAngle: -CGFloat.pi/2, endAngle: test, clockwise: true)
            
            shapeLayer.path = progressPath.cgPath
            //set color of the ring around the circle
            shapeLayer.strokeColor = UIColor.green.cgColor
            //set the width of the ring around the circle
            shapeLayer.lineWidth = 10
            shapeLayer.strokeEnd = 0
            shapeLayer.lineCap = .round
            shapeLayer.fillColor = UIColor.clear.cgColor
            
            
            //draw the above
            view.layer.addSublayer(shapeLayer)
            
            //animation
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            
            basicAnimation.toValue = 1
            basicAnimation.duration = 1
            
            //makes the animation stay on screen
            basicAnimation.fillMode = .forwards
            basicAnimation.isRemovedOnCompletion = false
            
            shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        }
    
    func saveXp(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        ref.child("users").child(uid).child("xp").setValue(lvlSystem.xp)
    }
    
    func getXp(){
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).child("xp").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            var value = snapshot.value as? Double
            
            //if the value does not excist in database create it and set to 0.0
            if value == nil {
                self.ref.child("users").child(uid!).child("xp").setValue(self.lvlSystem.xp)
                value = 0.0
            }
            self.lvlSystem.xp = value!
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    

}

