//
//  CurrentUser.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008
//
//  Created by Anjalee on 3/1/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import Foundation

struct CurrentUser{
    
    let uid: String
    let firstName: String
    let lastName: String
    let email: String
    let department: String
   // let profileImageUrl: String
    let mobilNo: String
    
  /* init(uid: String?, fname: String?, lname: String?, email: String?, department: String?, profileImageUrl: String?, mobile: String?){
        
        self.uid = uid
        self.fname = fname
        self.lname = lname
        self.email = email
        self.department = department
        self.profileImageUrl = profileImageUrl
        self.mobile = mobile*/
   init(uid: String, dictionary: [String: Any]){
        self.uid = uid
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.department = dictionary["department"] as? String ?? ""
        self.mobilNo = dictionary["mobilNo"] as? String ?? ""
      //  self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""

}
}

