//
//  UserRegistration.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008Tests
//
//  Created by Anjalee on 3/1/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import XCTest
@testable import UserRegistration

class UserRegistrationTest: XCTestCase {

    var sut: UserRegistrationModelValidatorProtocol!
    let firstName = "Shanu"
    let lastName = "Kulathunga"
    let email = "shanu@gmail.com"
    let password = "12345678"
    let repeatPassword = "12345678"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testUserModelStruc_canCreateNewInstance() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    repeatPassword: repeatPassword)
        
        XCTAssertNotNil(sut)
    }
    
    func testUserFirstName_shouldPassIfValidFirstName() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    repeatPassword: repeatPassword)
        
        XCTAssertTrue(sut.isValidFirstName())
    }
    
    func testUserFirstName_shouldPassIfFirstNameLessThanMinLength() {
        sut = UserRegistrationModel(firstName: "S",
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    repeatPassword: repeatPassword)
        
        XCTAssertFalse(sut.isValidFirstName())
    }
    
    func testUserLastName_shouldPassIfValidLastName() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    repeatPassword: repeatPassword)
        
        XCTAssertTrue(sut.isValidLastName())
    }
    
    func testUserLastName_shouldPassIfLastNameLessThanMinLength() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: "K",
                                    email: email,
                                    password: password,
                                    repeatPassword: repeatPassword)
        
        XCTAssertFalse(sut.isValidLastName())
    }
    
    func testUserRegistrationModel_shouldPassIfValidEmail() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    repeatPassword: repeatPassword)
        
        XCTAssertTrue(sut.isValidEmail())
    }
    
    func testUserRegistrationModel_shouldPassIfInValidEmail() {
        
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: "test.com",
                                    password: password,
                                    repeatPassword: repeatPassword)
        
        XCTAssertFalse(sut.isValidEmail())
    }
    
    func testUserRegistrationModel_shouldPassIfValidPasswordLength() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    repeatPassword: repeatPassword)
        
        XCTAssertTrue(sut.isValidPasswordLength())
    }
    
    func testUserPassword_passwordAndRepeatPasswordMustMatch() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    repeatPassword: repeatPassword)
        
        XCTAssertTrue(sut.doPasswordsMatch())
    }
    
    func testUserPassword_shouldPassIfPasswordIsValid() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    repeatPassword: repeatPassword)
        
        XCTAssertTrue(sut.isValidPassword())
    }


}
