//
//  UserRegistrationModel.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008Tests
//
//  Created by Anjalee on 3/1/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import Foundation
struct UserRegistrationModel {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let confirmPassword: String
    let departmentName:String
    let mobile: String
}
extension UserRegistrationModel {
    func isValidFirstName() -> Bool {
        return firstName.count > 1
    }
    
    func isValidLastName() -> Bool {
        return lastName.count > 1
    }
    func isValidEmail() -> Bool {
        return email.contains("@") && email.contains(".")
    }
    func isValidPasswordLength() -> Bool {
        return password.count >= 8 && password.count <= 16
    }
    
    func doPasswordsMatch() -> Bool {
        return password == confirmPassword
    }
    
    func isValidPassword() -> Bool {
        return isValidPasswordLength() && doPasswordsMatch()
    }
    func isValidDepartment() -> Bool {
       return departmentName.count > 1
    }
    func isValidMobile() -> Bool {
        return mobile.count > 1
    }
    
    func isDataValid() -> Bool {
        return isValidFirstName() && isValidLastName() && isValidEmail() && isValidPasswordLength() &&
            doPasswordsMatch() && isValidDepartment() && isValidMobile()
}
}
