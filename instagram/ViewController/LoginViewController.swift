//
//  LoginViewController.swift
//  instagram
//
//  Created by Brandon Shimizu on 9/26/18.
//  Copyright © 2018 Brandon Shimizu. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userloginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: userloginField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("You're Logged In!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = userloginField.text
        newUser.password = passwordField.text
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("Yay! Created a User!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)

            }
            else {
                print(error?.localizedDescription)
                if error?._code == 202 {
                    print("Username is Taken")
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
