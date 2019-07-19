//
//  LogInPage.swift
//  SEAC_Project_Experimentation
//
//  Created by Student on 7/15/19.
//  Copyright © 2019 SEAC_Organization. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInPage: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle? = nil
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var alert: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func logInAttempt(_ sender: Any) {
        guard let email = userEmail.text, let password = userPassword.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.alert.isHidden = false
                self.alert.text = "Invalid login, try again or sign up"
                print(error.localizedDescription)
                return
            }
            self.alert.isHidden = true
        self.performSegue(withIdentifier: "logInSuccess", sender: nil)
        print("Log In Success!")
        }
    }
}
