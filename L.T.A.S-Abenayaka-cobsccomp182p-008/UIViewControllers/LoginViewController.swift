//
//  LoginViewController.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/20/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUpElements()
    }
    

    func setUpElements() {
        
        // Hide the error label
        lblError.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(txtEmail)
        Utilities.styleTextField(txtPassword)
        Utilities.styleFilledButton(btnLogin)
        
    }
    func showError(_ message:String) {
        
        lblError.text = message
        lblError.alpha = 1
    }

    @IBAction func btnSignUpNavigation(_ sender: Any) {
        
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpViewController
        let navController = UINavigationController(rootViewController: VC1)
        
        self.present(navController, animated:true, completion: nil)
    }
    @IBAction func LoginTapped(_ sender: Any) {
        // Create cleaned versions of the text field
        let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.showError("Please check your credentials")
            }
            else {
                
                //  let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? EventHomeViewController
                
                let homeTabViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeTabViewController) as? HomeTabBarViewController
                
                self.view.window?.rootViewController = homeTabViewController
                self.view.window?.makeKeyAndVisible()
                
            }
        }
    }
    
    @IBAction func ForgotPasswordTapped(_ sender: Any) {
        let forgotPassAlert = UIAlertController(title: "Forgot password?", message: "Enter email address", preferredStyle: .alert)
        forgotPassAlert.addTextField { (textField) in
            textField.placeholder = "Enter email address"
        }
        forgotPassAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        forgotPassAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: { (action) in
            let resetEmail = forgotPassAlert.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
                if error != nil{
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }else {
                    let resetEmailSentAlert = UIAlertController(title: "Reset email sent successfully", message: "Reset email has been sent to your login email, please follow the instructions in the mail to reset your password", preferredStyle: .alert)
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            })
        }))
        //PRESENT ALERT
        self.present(forgotPassAlert, animated: true, completion: nil)
    }
    
}
