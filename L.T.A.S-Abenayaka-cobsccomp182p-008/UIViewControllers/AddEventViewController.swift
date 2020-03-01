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
import Firebase
import SwiftyJSON
import MapKit

class AddEventViewController: UIViewController{
    
  

    @IBOutlet weak var EventImage: UIImageView!
    @IBOutlet weak var txtEventTitle: UITextField!
    @IBOutlet weak var txtEventDesc: UITextField!
    @IBOutlet weak var txtEventSummary: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    
    var imagePicker:UIImagePickerController!
    var ref = DatabaseReference.init()
    var avatarImageUrl: String!
    var firstname: String!
    
    var refEvents: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.ref = Database.database().reference()
        EventImage.isUserInteractionEnabled = true
        setUpElements()
        
        self.EventImage.layer.borderColor = UIColor.lightGray.cgColor
        self.EventImage.layer.borderWidth = 1
      
    }
    
    func setUpElements() {
        
        // Hide the error label
        lblError.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(txtEventTitle)
        Utilities.styleTextField(txtEventDesc)
        Utilities.styleTextField(txtLocation)
        Utilities.styleTextField(txtEventSummary)
       // Utilities.styleFilledButton(btnShare)
       // Utilities.styleFilledButton(btnUpload)
      //  Utilities.styleFilledButton(btnLocation)
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
    

    @IBAction func btnUploadImage(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnAddLocation(_ sender: Any) {
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
    @IBAction func btnShareEvent(_ sender: Any) {
      // addEvent()
        let alert = AlertMessage()
        if (txtEventTitle.text == "") {
            alert.showAlert(title: "Event", message: "Title is required:",buttonText: "Add Event")
            return
        }
        
        if (txtEventDesc.text == ""){
            alert.showAlert(title: "Event", message: "Description is required:",buttonText: "Add Event")
            return
        }
        if (EventImage.image == nil){
            alert.showAlert(title: "Event", message: "Event Image is required:",buttonText: "Add Event")
            return
        }
        if (txtEventSummary.text == nil){
            alert.showAlert(title: "Event", message: "Event Summery is required:",buttonText: "Add Event")
            return
        }
        if (txtLocation.text == nil){
            alert.showAlert(title: "Event", message: "Location is required:",buttonText: "Add Event")
            return
        }
        self.saveFIRData()
        navigationController?.popViewController(animated: true)
        alert.showAlert(title: "Event", message: "Event added successfully:",buttonText: "Event Home")
        
        let homeTabViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeTabViewController) as? HomeTabBarViewController
        
        self.view.window?.rootViewController = homeTabViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func saveFIRData(){
        self.uploadMedia(image: EventImage.image!){ url in
            self.saveImage(profileImageURL: url!){ success in
                if (success != nil){
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func uploadMedia(image :UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("events").child(imageName)
        let imgData = self.EventImage.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil{
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            }else{
                print("error in save image")
                completion(nil)
            }
        }
    }
    
    func saveImage(profileImageURL: URL , completion: @escaping ((_ url: URL?) -> ())){
       // let alert = AlertMessage()
        let dict = ["description": txtEventDesc.text!, "imageUrl": profileImageURL.absoluteString,"event_title": txtEventTitle.text!,"summery": txtEventSummary.text!,"location": txtLocation.text!] as [String : Any]
        self.ref.child("events").childByAutoId().setValue(dict)
        //alert.showAlert(title: "Event", message: "Event added successfully:",buttonText: "Event Home")
    }
    

func clearFields()  {
    txtEventTitle.text = ""
    txtEventDesc.text = ""
    txtEventSummary.text = ""
    
}

}
extension AddEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.EventImage.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
