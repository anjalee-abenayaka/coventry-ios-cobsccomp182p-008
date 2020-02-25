//
//  PostedEventViewController.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/25/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit
import Nuke
import Firebase
import LocalAuthentication

class PostedEventViewController: UIViewController {

    var posts: EventModel? = nil
    
    @IBOutlet weak var LblEventTitle: UILabel!
    @IBOutlet weak var ImageEvent: UIImageView!
    @IBOutlet weak var txViewDescription: UITextView!
    @IBOutlet weak var lblSummery: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var txtViewComment: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // ImageEvent.layer.cornerRadius = ImageEvent.frame.width / 2
     self.txtViewComment.layer.borderColor = UIColor.lightGray.cgColor
     self.txtViewComment.layer.borderWidth = 1
       // self.txtViewComment.text = " Comment Here .."
        
        if posts != nil{
            
            let url = URL(string: ((posts?.imageUrl)!))
            
            Nuke.loadImage(with: url!, into: ImageEvent)
            
            LblEventTitle.text = posts?.event_title
            txViewDescription.text = posts?.description
            lblSummery.text = posts?.summery
            lblLocation.text = posts?.location
        }
        
    }
    

    @IBAction func btnSignOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    

}
