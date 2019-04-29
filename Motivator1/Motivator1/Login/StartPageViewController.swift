//
//  StartPageViewController.swift
//  Motivator1
//
//  Created by Mathias Larsen on 21/02/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import UIKit
import FirebaseAuth

class StartPageViewController: UIViewController {

    var user = User.user
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Auth.auth().currentUser != nil {
            user.fillArray()
            self.performSegue(withIdentifier: "GoHome3", sender: nil)
        }
    }
    
    @IBAction func Login(_ sender: Any) {
        self.performSegue(withIdentifier: "Login", sender: self)
    }
    
    
    @IBAction func SignUp(_ sender: Any) {
        self.performSegue(withIdentifier: "SignUp", sender: self)
    }

}
