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
import FirebaseFirestore
import FirebaseStorage

class SignUpViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var btnProfileImage: UIButton!
    @IBOutlet weak var imgProfilePicture: UIImageView!
    @IBOutlet weak var txtFname: UITextField!
    @IBOutlet weak var txtLname: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtDepartment: UITextField!
    @IBOutlet weak var BtnSignUp: UIButton!
    @IBOutlet weak var lblError: UILabel!
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpElements()
        uploadProfilePic()
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
    
    @IBAction func btnSkipToEventsHome(_ sender: Any) {
        let bforeLoginEventHomeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.bforeLoginEventHomeViewController) as? BeforeLoginEventHomeViewController
        
        self.view.window?.rootViewController = bforeLoginEventHomeViewController
        self.view.window?.makeKeyAndVisible()
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
                //    let imageName = NSUUID().uuidString
                    let storageRef = Storage.storage().reference(forURL: "gs://ios-course-work.appspot.com").child("profile_image").child(result!.user.uid)
                    if let imgProfilePicture = self.selectedImage, let imageData = imgProfilePicture.jpegData(compressionQuality: 0.1){
                        storageRef.putData(imageData, metadata: nil, completion: { (metadata, error ) in
                            if error != nil{
                               // alert.showAlert(title: "Error", message: "Image Upload Error Please Re-check", buttonText: "Okay")
                                self.showError("Image Upload Error, Try Again")
                            }
                           
                        })

                    }
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "department":department, "mobile":mobile, "email":email, "password":password, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                          
                            self.showError("Error saving user data")
                        }else{
                              self.clearFields()
                            
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToLogin()
                }
                
            }
            
        }
            
        }

    
    
    func transitionToLogin() {
        
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as? LoginViewController
        
        self.view.window?.rootViewController = loginViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    func uploadProfilePic(){
        
        profileImg.layer.cornerRadius = 10
        profileImg.clipsToBounds = true
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectProfileImageView))
        profileImg.addGestureRecognizer(tapGuesture)
        profileImg.isUserInteractionEnabled = true
    }
    
    @objc func handleSelectProfileImageView(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    func clearFields()  {
        txtFname.text = ""
        txtLname.text = ""
        txtPassword.text = ""
        txtEmail.text = ""
        txtMobile.text = ""
        txtDepartment.text = ""
        txtConfirmPass.text = ""
    }
}
extension SignUpViewController{
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage {
                selectedImage = image
                profileImg.image = image
            }
            print(info)
            
            dismiss(animated: true, completion: nil)
        }
    }


