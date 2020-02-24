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
import  Firebase

class EventHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   

    @IBOutlet weak var eventTableView: UITableView!
    
    var eventList = [EventModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventTableViewCell
        
        //the artist object
        let event: EventModel
        
        //getting the artist of selected position
        event = eventList[indexPath.row]
        
        //adding values to labels
        cell.lblEventTitle.text = event.event_title
        cell.lblDescription.text = event.description
        cell.lblSummery.text = event.summery
        cell.lblLocation.text = event.location
        
        //returning cell
        return cell
    }
    
    
    var refEvents: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       refEvents = Database.database().reference().child("events");
        
        //observing the data changes
        refEvents.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.eventList.removeAll()
                
                //iterating through all the values
                for events in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let eventObject = events.value as? [String: AnyObject]
                    let event_title  = eventObject?["event_title"]
                    let eventId  = eventObject?["id"]
                    let description = eventObject?["description"]
                    let summery = eventObject?["summery"]
                    let location = eventObject?["location"]
                    
                    //creating artist object with model and fetched values
                    let event = EventModel(id: eventId as! String?, event_title: event_title as! String?, description: description as! String?, summery: summery as! String?, location: location as! String?)
                    
                    //appending it to list
                    self.eventList.append(event)
                }
                
                //reloading the tableview
                self.eventTableView.reloadData()
            }
        })
        
    }
    
   

}
