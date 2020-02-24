//
//  EventModel.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/23/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

class EventModel {
    
    var id: String?
    var event_title: String?
    var description: String?
    var summery: String?
    var location: String?
    
    init(id: String?, event_title: String?, description: String?, summery: String?, location: String?){
        self.id = id
        self.event_title = event_title
        self.description = description
        self.summery = summery
        self.location = location
    }
}
