//
//  ViewController.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/20/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var BtnSignUp: UIButton!
    @IBOutlet weak var BtnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements(){
        Utilities.styleFilledButton(BtnSignUp)
        Utilities.styleFilledButton(BtnLogin)
    }

    
    @IBAction func btnSkiptoHome(_ sender: Any) {
        let bforeLoginEventHomeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.bforeLoginEventHomeViewController) as? BeforeLoginEventHomeViewController
        
        self.view.window?.rootViewController = bforeLoginEventHomeViewController
        self.view.window?.makeKeyAndVisible()
    }
}

