//
//  MyProfileEditViewController.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/27/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import Nuke

class MyProfileEditViewController: UIViewController {

    @IBOutlet weak var ImageMyProfile: UIImageView!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtDepartmentName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    
    var window: UIWindow?
    
    var imagePicker:UIImagePickerController!
    var ref = DatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.ref = Database.database().reference()
        
        ImageMyProfile.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        self.window = UIWindow(frame: UIScreen.main.bounds)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSkip(_ sender: Any) {
        let bforeLoginEventHomeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.bforeLoginEventHomeViewController) as? BeforeLoginEventHomeViewController
        
        self.view.window?.rootViewController = bforeLoginEventHomeViewController
        self.view.window?.makeKeyAndVisible()
    }
    func setUpElements() {
        
        // Style the elements
        Utilities.styleTextField(txtFName)
        Utilities.styleTextField(txtMobile)
        Utilities.styleTextField(txtLName)
        Utilities.styleTextField(txtDepartmentName)
    
    }
    
    @IBAction func btnBackToMyProfile(_ sender: Any) {
        let myProfieViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.myProfieViewController) as? MyProfileViewController
        
        self.view.window?.rootViewController = myProfieViewController
        self.view.window?.makeKeyAndVisible()
    }
    @IBAction func btnUploadImage(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnUpdateProfile(_ sender: Any) {
         let alert = AlertMessage()
        if (txtFName.text == "") {
            alert.showAlert(title: "MyProfile", message: "First Name is required:",buttonText: "Update Profile")
            return
        }
        
        if (txtLName.text == ""){
            alert.showAlert(title: "MyProfile", message: "Last Name is required:",buttonText: "Update Profile")
            return
        }
        if (txtDepartmentName.text == ""){
            alert.showAlert(title: "MyProfile", message: "Department Name is required:",buttonText: "Update Profile")
            return
        }
        if (txtMobile.text == ""){
            alert.showAlert(title: "MyProfile", message: "Mobile is required:",buttonText: "Update Profile")
            return
        }
        if (ImageMyProfile.image == nil){
            alert.showAlert(title: "MyProfile", message: "Image is required:",buttonText: "Update Profile")
            return
        }
        self.saveFIRData()
        navigationController?.popViewController(animated: true)
    }
    
    func saveFIRData(){
        self.uploadMedia(image: ImageMyProfile.image!){ url in
            self.saveImage(profileImageURL: url!){ success in
                if (success != nil){
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func uploadMedia(image :UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("users").child(imageName)
        let imgData = self.ImageMyProfile.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil{
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            }else{
                print("error in save image")
                completion(nil)
            }
        }
    }
    

    func saveImage(profileImageURL: URL , completion: @escaping ((_ url: URL?) -> ())){
         let alert = AlertMessage()
        let loggedUserEmail = UserDefaults.standard.string(forKey: "LoggedUser")
        let dict = ["firstName": txtFName.text!,
                    "lastName": txtLName.text!,
                    "imageUrl": profileImageURL.absoluteString,
                    "mobilNo": txtMobile.text!,
                    "department": txtDepartmentName.text!,
                    "email":loggedUserEmail!] as [String : Any]
        self.ref.child("users").childByAutoId().setValue(dict)
        alert.showAlert(title: "Profile", message: "Profile Updated Successfully:",buttonText: "Event Home")
    }

}
extension MyProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.ImageMyProfile.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
