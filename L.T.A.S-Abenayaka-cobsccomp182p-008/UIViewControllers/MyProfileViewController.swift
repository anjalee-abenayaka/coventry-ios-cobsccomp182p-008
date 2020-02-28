//
//  MyProfileViewController.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/21/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit
import LocalAuthentication

class MyProfileViewController: UIViewController {
var window: UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnEditMyProfile(_ sender: Any) {
        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MyProfileEdit")
                        
                        self.window?.rootViewController = initialViewController
                        self.window?.makeKeyAndVisible()
                    }
    }
    

