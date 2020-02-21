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

}

