//
//  MyProfileViewController.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/21/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit
import LocalAuthentication
import FirebaseFirestore
import FirebaseAuth
import Firebase

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var lblFname: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var lblLname: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblDepartment: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    var window: UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        handelFetchUserButtonTapped()
    }
    
func handelFetchUserButtonTapped(){
        if Auth.auth().currentUser != nil{
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dict = snapshot.value as? [String: Any] else { return }
                let user = CurrentUser(uid: uid, dictionary: dict)
                self.lblFname.text = user.firstName
                self.lblLname.text = user.lastName
                self.lblEmail.text = user.email
                self.lblDepartment.text = user.department
                self.lblMobile.text = user.mobilNo
                
                //self.ProfileImage.loa(urlString: user.profileImageUrl)
                
            }, withCancel: { (err) in
                print(err)
            })
        }
    }
    
    @IBAction func NavBackToProfile(_ sender: Any) {
        let myProfieViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.myProfieViewController) as? MyProfileViewController
        
        self.view.window?.rootViewController = myProfieViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func NavBacktoHome(_ sender: Any) {
        let homeTabViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeTabViewController) as? HomeTabBarViewController
        
        self.view.window?.rootViewController = homeTabViewController
        self.view.window?.makeKeyAndVisible()
    }
    @IBAction func btnEditMyProfile(_ sender: Any) {
        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MyProfileEdit")
                        
                        self.window?.rootViewController = initialViewController
                        self.window?.makeKeyAndVisible()
                    }
    }
    

