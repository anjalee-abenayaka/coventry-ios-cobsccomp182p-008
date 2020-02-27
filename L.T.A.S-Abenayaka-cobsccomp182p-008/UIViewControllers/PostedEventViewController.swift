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
import MapKit

class PostedEventViewController: UIViewController {

    var posts: EventModel? = nil
    
  
    @IBOutlet weak var EventTitleLbl: UILabel!
    @IBOutlet weak var EventImage: UIImageView!
    @IBOutlet weak var DescriptionTxtView: UITextView!
    @IBOutlet weak var SummeryLbl: UILabel!
    @IBOutlet weak var LocationLbl: UILabel!
    @IBOutlet weak var CommentTxtView: UITextView!
    @IBOutlet weak var SendBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // ImageEvent.layer.cornerRadius = ImageEvent.frame.width / 2
     self.CommentTxtView.layer.borderColor = UIColor.lightGray.cgColor
     self.CommentTxtView.layer.borderWidth = 1
       // self.txtViewComment.text = " Comment Here .."
        
        if posts != nil{
            
            let url = URL(string: ((posts?.imageUrl)!))
            
            Nuke.loadImage(with: url!, into: EventImage)
            
            EventTitleLbl.text = posts?.event_title
            DescriptionTxtView.text = posts?.description
            SummeryLbl.text = posts?.summery
            LocationLbl.text = posts?.location
        }
        
    }
    
    @IBAction func btnGooglemapDirection(_ sender: Any) {
        let latitude:CLLocationDegrees = 6.906629
        let logitutde:CLLocationDegrees = 79.870651
        
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude,logitutde)
        let regionSpan = MKCoordinateRegion(center: coordinates,latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "NIBM"
        mapItem.openInMaps(launchOptions: options)
    }
    
    @IBAction func btnHomeNav(_ sender: Any) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "HomeVC") as! HomeTabBarViewController
        let navController = UINavigationController(rootViewController: VC1)
        
        self.present(navController, animated:true, completion: nil)
    }
    
}
