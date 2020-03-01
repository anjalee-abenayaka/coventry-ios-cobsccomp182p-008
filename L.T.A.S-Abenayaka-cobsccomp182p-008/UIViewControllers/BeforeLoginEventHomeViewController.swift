//
//  BeforeLoginEventHomeViewController.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 3/1/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase
import LocalAuthentication

class BeforeLoginEventHomeViewController: UIViewController {
    var eventList : [EventModel] = []
    var ref: DatabaseReference!
    var window: UIWindow?
    
    @IBOutlet weak var EventTableView: UITableView!
    var refEvents: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        EventTableView.dataSource = self
        EventTableView.delegate = self
        getEventData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLoginNavigation(_ sender: Any) {
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as? LoginViewController
        
        self.view.window?.rootViewController = loginViewController
        self.view.window?.makeKeyAndVisible()
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
            
            self.EventTableView.reloadData()
            
            
        }
        
    }
    

}

extension BeforeLoginEventHomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! BeforeLoginEventTableViewCell
        
        eventCell.selectionStyle = .none
        
        eventCell.populateData(post: eventList[indexPath.row])
        
        
        return eventCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
