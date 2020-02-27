//
//  EventHomeViewController.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/20/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase
import LocalAuthentication

class EventHomeViewController: UIViewController{
    var eventList : [EventModel] = []
    var ref: DatabaseReference!
    var window: UIWindow?
   

    @IBOutlet weak var eventTableView: UITableView!
    

    var refEvents: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        eventTableView.dataSource = self
        eventTableView.delegate = self
        getEventData()
       
        
    }
    
    @IBAction func btnSignOut(_ sender: Any) {
        let alert = AlertMessage()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        UserDefaults.standard.removeObject(forKey: "LoggedUser")
        UserDefaults.standard.removeObject(forKey: "LoggedIn")
        UserDefaults.standard.removeObject(forKey: "UserUID")
        UserDefaults.standard.synchronize()
        
        alert.showAlert(title: "Signed out successfully", message: "You have been successfully Log Out", buttonText: "Okay")
        
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        let navController = UINavigationController(rootViewController: VC1)
        
        self.present(navController, animated:true, completion: nil)

    }
    

    func getEventData(){
         let eventsRef = ref.child("events")
        
        eventsRef.observe(.value){ snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let eventDic = child.value as! NSDictionary
                
                let event_title = eventDic["event_title"] as! String
                let description = eventDic["description"] as! String
                let location = eventDic["location"] as! String
                let imageUrl = eventDic["imageUrl"] as! String
                let summery = eventDic["summery"] as! String
                let post = EventModel(
                    event_title: event_title,
                    description: description,
                    summery: summery,
                    location: location,
                    
                    imageUrl: imageUrl
                )
                
                self.eventList.append(post)
                
                print(child)
            }
            
            self.eventTableView.reloadData()
            
            
        }
        
    }
}

extension EventHomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventTableViewCell
        
        eventCell.selectionStyle = .none
        
        eventCell.populateData(post: eventList[indexPath.row])
        
        return eventCell
    }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "eventDetail", sender: eventList[indexPath.row])
    }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventDetail" {
            if let viewController = segue.destination as? PostedEventViewController{
                
                viewController.posts = sender as? EventModel
            }
        }
    }
}

