//
//  SignUpViewController.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/20/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtFname: UITextField!
    @IBOutlet weak var txtLname: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtDepartment: UITextField!
    @IBOutlet weak var BtnSignUp: UIButton!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpElements()
        // Do any additional setup after loading the view.
    }
    

    func setUpElements() {
        
        // Hide the error label
        lblError.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(txtFname)
        Utilities.styleTextField(txtLname)
        Utilities.styleTextField(txtEmail)
        Utilities.styleTextField(txtPassword)
        Utilities.styleTextField(txtConfirmPass)
        Utilities.styleTextField(txtMobile)
        Utilities.styleTextField(txtDepartment)
        Utilities.styleFilledButton(BtnSignUp)
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if txtFname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtLname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtConfirmPass.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtDepartment.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtMobile.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        //checking password
        if self.txtPassword.text != self.txtConfirmPass.text {
            return "Pass codes do not match."
        }
        
        return nil
        
    }
    
    func showError(_ message:String) {
        
        lblError.text = message
        lblError.alpha = 1
    }
    
    
    @IBAction func BtnSignUp(_ sender: Any) {
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = txtFname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = txtLname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let department = txtDepartment.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let mobile = txtMobile.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "department":department, "mobile":mobile, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
                
            }
            
            
            
        }

    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? EventHomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
}
