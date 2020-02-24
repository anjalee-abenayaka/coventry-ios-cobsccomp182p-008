//
//  AddEventViewController.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/23/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import  Firebase

class AddEventViewController: UIViewController{
    
  

    @IBOutlet weak var EventImage: UIImageView!
    @IBOutlet weak var txtEventTitle: UITextField!
    @IBOutlet weak var txtEventDesc: UITextField!
    @IBOutlet weak var txtEventSummary: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblError: UILabel!
    
    
    
    var refEvents: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpElements()
       // FirebaseApp.configure()
        refEvents = Database.database().reference().child("events");
      
    }
    
    
    func addEvent(){
        //generating a new key inside artists node
        //and also getting the generated key
        let error = validateFields()
        let alert = AlertMessage()
        
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            // Create cleaned versions of the data
            _ = txtEventTitle.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            _ = txtEventDesc.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            _ = txtEventSummary.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            _ = txtLocation.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            self.btnShare.loadingIndicator(show: true)
        let key = refEvents.childByAutoId().key
        
        //creating artist with the given values
        let event = ["id":key,
                      "event_title": txtEventTitle.text! as String,
                      "description": txtEventDesc.text! as String,
                      "summery": txtEventSummary.text! as String,
                      "location": txtLocation.text! as String
        ]
        
        //adding the artist inside the generated unique key
        refEvents.child(key!).setValue(event)
        alert.showAlert(title: "Event", message: "Event added successfully:",buttonText: "Event Home")
            
            let homeTabViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeTabViewController) as? HomeTabBarViewController
            
            self.view.window?.rootViewController = homeTabViewController
            self.view.window?.makeKeyAndVisible()
            
            }
            
        }



    func setUpElements() {
        
        // Hide the error label
        lblError.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(txtEventTitle)
        Utilities.styleTextField(txtEventDesc)
        Utilities.styleTextField(txtLocation)
        Utilities.styleTextField(txtEventSummary)
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if txtEventTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtEventDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtEventSummary.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtLocation.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
             {
            
            return "Please fill in all fields."
        }
        
        
        return nil
        
    }
    
    func showError(_ message:String) {
        
        lblError.text = message
        lblError.alpha = 1
    }
    

    
    @IBAction func btnShareEvent(_ sender: Any) {
       addEvent()
    }
    

func clearFields()  {
    txtEventTitle.text = ""
    txtEventDesc.text = ""
    txtEventSummary.text = ""
    
}

}
