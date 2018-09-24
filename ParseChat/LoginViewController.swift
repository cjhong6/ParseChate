//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Chengjiu Hong on 9/23/18.
//  Copyright © 2018 Chengjiu Hong. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignup(_ sender: Any) {
        checkEmptyField()
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground{ (sucess: Bool, error: Error?) in
            if let error = error{
                let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                alertController.addAction(OKAction)
                DispatchQueue.global().async(execute: {
                    DispatchQueue.main.sync{
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            }else{
                print("User sign up sucessfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        checkEmptyField()
        let username = usernameField.text
        let password = passwordField.text
        
        PFUser.logInWithUsername(inBackground: username!, password: password!, block: {(user: PFUser?, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                alertController.addAction(OKAction)
                DispatchQueue.global().async(execute: {
                    DispatchQueue.main.sync{
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            } else {
                print("User login successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        })
    }
    
    func checkEmptyField(){
        if((usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)!){
            let alertController = UIAlertController(title: "Error", message: "Please enter username or password", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alertController.addAction(OKAction)
            present(alertController, animated: true) {
            }
        }
    }
    

}
