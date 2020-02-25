//
//  EventTableViewCell.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/23/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit
import Nuke

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblSummery: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateData(post: EventModel)  {
        
        lblEventTitle.text = post.event_title
        lblDescription.text = post.description
        lblSummery.text = post.summery
        lblLocation.text = post.location
        
        let imgUrl = URL(string: post.imageUrl!)
        
        Nuke.loadImage(with: imgUrl!, into: imgEvent)
        
    }

}
