//
//  FirstViewController.swift
//  Motivator1
//
//  Created by Mathias Larsen on 20/02/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var lvlSystem = LvlSystem()
    //new shapelayer
    let shapeLayer = CAShapeLayer()
    
    @IBOutlet weak var Lvl: UILabel!
    
    @IBOutlet weak var XpRemaning: UILabel!
    
    
    
    @IBOutlet weak var XpInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Lvl.text = "\(lvlSystem.getLvl())"
        XpRemaning.text = "\(lvlSystem.xpRemaningToNextLvl()) xp remaning for next lvl"
        
        animateCircle()
    }
    
    
    @IBAction func SubmitButton(_ sender: Any) {
        
        if let newxp = Double(XpInput.text!){
            lvlSystem.addXp(newXp: newxp)
            
            animateCircle()
            
            viewDidLoad()
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

    

}

