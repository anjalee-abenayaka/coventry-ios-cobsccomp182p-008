//
//  TouchFaceIdViewController.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/21/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import LocalAuthentication

class TouchFaceIdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func btnFaceId(_ sender: Any) {
        let alert = AlertMessage()
        
        let localAuthenticationContext = LAContext()
        
        localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"
        
        var authorizationError: NSError?
        
        let reason = "Authentication is required for you to continue"
        
        if localAuthenticationContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &authorizationError) {
            
            _ = localAuthenticationContext.biometryType == LABiometryType.faceID ? "Face ID" : "Touch ID"
            
            
            localAuthenticationContext.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: reason) { (success, evaluationError) in
                if success {
                    
                   // alert.showAlert(title: "Success", message: "Awesome!!... User authenticated successfully.",buttonText: "Okay")
                    
                    let myProfieViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.myProfieViewController) as? MyProfileViewController
                    
                    self.view.window?.rootViewController = myProfieViewController
                    self.view.window?.makeKeyAndVisible()
                    
                } else {
                    alert.showAlert(title: "Error", message: "Error occured",buttonText: "Okay")
                    
                    if let errorObj = evaluationError {
                        let messageToDisplay = self.getErrorDescription(errorCode: errorObj._code)
                        
                        alert.showAlert(title: "Error", message: messageToDisplay,buttonText: "Okay")
                        
                    }
                }
            }
            
        } else {
            
            alert.showAlert(title: "Error", message: "User has not enrolled into using Biometricsd",buttonText: "Okay")
            
        }

    }
    
    
    @IBAction func btnTouchId(_ sender: Any) {
        // 1
        let context = LAContext()
        var error: NSError?
        
        // 2
        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 3
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                {(success, error) in
                    // 4
                    if success {
                        self.showAlertController("Touch ID Authentication Succeeded")
                        let myProfieViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.myProfieViewController) as? MyProfileViewController
                        
                        self.view.window?.rootViewController = myProfieViewController
                        self.view.window?.makeKeyAndVisible()
                    }
                    else {
                        self.showAlertController("Touch ID Authentication Failed")
                    }
            })
        }
            // 5
        else {
            showAlertController("Touch ID not available")
        }
        
        
    }
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func getErrorDescription(errorCode: Int) -> String {
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            return "Authentication was not successful, because user failed to provide valid credentials."
            
        case LAError.appCancel.rawValue:
            return "Authentication was canceled by application (e.g. invalidate was called while authentication was in progress)."
            
        case LAError.invalidContext.rawValue:
            return "LAContext passed to this call has been previously invalidated."
            
        case LAError.notInteractive.rawValue:
            return "Authentication failed, because it would require showing UI which has been forbidden by using interactionNotAllowed property."
            
        case LAError.passcodeNotSet.rawValue:
            return "Authentication could not start, because passcode is not set on the device."
            
        case LAError.systemCancel.rawValue:
            return "Authentication was canceled by system (e.g. another application went to foreground)."
            
        case LAError.userCancel.rawValue:
            return "Authentication was canceled by user (e.g. tapped Cancel button)."
            
        case LAError.userFallback.rawValue:
            return "Authentication was canceled, because the user tapped the fallback button (Enter Password)."
            
        default:
            return "Error code \(errorCode) not found"
        }
    }
    

}
