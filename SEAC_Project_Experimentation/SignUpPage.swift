//
//  SignUpPage.swift
//  SEAC_Project_Experimentation
//
//  Created by Student on 7/15/19.
//  Copyright © 2019 SEAC_Organization. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignInPage: UIViewController {
    var is_Selected = false
    @IBOutlet weak var newEmail: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var alert: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var agreementButton: UIButton!
    @IBAction func pressed(_ sender: Any) {
        if is_Selected {
            agreementButton.setImage(#imageLiteral(resourceName: "unchecked-checkbox"), for: .normal)
            is_Selected = false
        }
        else {
            agreementButton.setImage(#imageLiteral(resourceName: "checked-checkbox"), for: .normal)
            is_Selected = true
        }
    }
    
    @IBAction func signUpAttempt(_ sender: Any) {
        if is_Selected {
            Auth.auth().createUser(withEmail: newEmail.text!, password: newPassword.text!) { (result, error) in
                if let error = error {
                    self.alert.isHidden = false
                    self.alert.text = error.localizedDescription
                    return
                }
            
                guard let uid = result?.user.uid else { return }
            
                let values = ["email": self.newEmail.text, "password": self.newPassword.text]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values as [AnyHashable : Any], withCompletionBlock: { (error, ref) in
                if let error = error {
                    print("Failed to update database values, ", error.localizedDescription)
                    return
                }
                self.performSegue(withIdentifier: "SignUpSuccess", sender: nil)
                print("Successful Sign Up!")
                })
            }
        }
        else {
            self.alert.isHidden = false
            self.alert.text = "Accept the terms and conditions before signing up"
        }
    }
}
