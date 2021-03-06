//
//  CreateUserViewController.swift
//  Motivator1
//
//  Created by Mathias Larsen on 21/02/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class CreateUserViewController: UIViewController {

    let firebase = Firebase.firebase
    let rest = REST.rest
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPass: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func CreateUser(_ sender: Any) {
       
        rest.createUser(username: txtEmail.text!)
        
        Auth.auth().createUser(withEmail: (txtEmail.text ?? ""), password: (txtPass.text ?? "")) { (result, error) in
            if let _eror = error {
                //something bad happning
                print(_eror.localizedDescription )
                print("der er sket en fejl")
            }else{
                //user registered successfully
                
                Auth.auth().signIn(withEmail: (self.txtEmail.text ?? ""), password: (self.txtPass.text ?? "")) { (result, error) in
                    if let _eror = error{
                        print(_eror.localizedDescription)
                    }else{
                        if let _res = result{
                            print(_res)
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000), execute: {
                    self.firebase.saveAchivements()
                    self.firebase.saveKcal()
                    self.firebase.saveXp()
                    self.firebase.saveDBUserId()
                    self.performSegue(withIdentifier: "GoHome", sender: self)
                })
            }
        }
 
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
