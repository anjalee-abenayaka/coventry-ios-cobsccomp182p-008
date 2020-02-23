
//
//  Handelr.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 2/23/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import UIKit

extension SignUpViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func handleSeletProfileImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        presentedViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let originalImage =
            info["UIImagePickerControllerOriginalImage"]{
            print(originalImage.size)
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        
    }
}
