//
//  LoginEmailViewController.swift
//  Motivator1
//
//  Created by Mathias Larsen on 21/02/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginEmailViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtPass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func LoginButton(_ sender: Any) {
    
        Auth.auth().signIn(withEmail: (txtEmail.text ?? ""), password: (txtPass.text ?? "")) { (result, error) in
            if let _eror = error{
                print(_eror.localizedDescription)
            }else{
                if let _res = result{
                    print(_res)
                    self.performSegue(withIdentifier: "GoHome2", sender: self)
                }
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
