//
//  AlertMessage.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/21/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import Foundation
import UIKit
class AlertMessage {
    func showAlert(title: String,message: String,buttonText: String)  {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButton(withTitle: buttonText)
        alert.show()
    }
}

