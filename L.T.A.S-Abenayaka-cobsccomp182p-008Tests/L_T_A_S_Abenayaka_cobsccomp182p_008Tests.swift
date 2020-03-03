//
//  L_T_A_S_Abenayaka_cobsccomp182p_008Tests.swift
//  L.T.A.S-Abenayaka-cobsccomp182p-008Tests
//
//  Created by Anjalee on 2/20/20.
//  Copyright © 2020 Anjalee Abenayaka. All rights reserved.
//

import XCTest
@testable import L_T_A_S_Abenayaka_cobsccomp182p_008

class L_T_A_S_Abenayaka_cobsccomp182p_008Tests: XCTestCase {

    var sut: UserRegistrationModel!
    let firstName = "Shanu"
    let lastName = "Kulathunga"
    let email = "shanu@gmail.com"
    let password = "12345678"
    let confirmPassword = "12345678"
    let departmentName = "IT"
    let mobile = "0786655675"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = nil
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUserModelStruc_canCreateNewInstance() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    departmentName: departmentName,
                                    mobile: mobile)
        
        XCTAssertNotNil(sut)
    }
    
    func testUserFirstName_shouldPassIfValidFirstName() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    departmentName: departmentName,
                                    mobile: mobile)
        
        XCTAssertTrue(sut.isValidFirstName())
    }
    
    func testUserFirstName_shouldPassIfFirstNameLessThanMinLength() {
        sut = UserRegistrationModel(firstName: "S",
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    departmentName: departmentName,
                                    mobile: mobile)
        
        XCTAssertFalse(sut.isValidFirstName())
    }
    
    func testUserLastName_shouldPassIfValidLastName() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    departmentName: departmentName,
                                    mobile: mobile)
        
        XCTAssertTrue(sut.isValidLastName())
    }
    
    func testUserLastName_shouldPassIfLastNameLessThanMinLength() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: "K",
                                    email: email,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    departmentName: departmentName,
                                    mobile: mobile)
        
        XCTAssertFalse(sut.isValidLastName())
    }
    
    func testUserRegistrationModel_shouldPassIfValidEmail() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    departmentName: departmentName,
                                    mobile: mobile)
        
        XCTAssertTrue(sut.isValidEmail())
    }
    
    func testUserRegistrationModel_shouldPassIfInValidEmail() {
        
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: "gmail.com",
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    departmentName: departmentName,
                                    mobile: mobile)
        
        XCTAssertFalse(sut.isValidEmail())
    }
    
    func testUserRegistrationModel_shouldPassIfValidPasswordLength() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    departmentName: departmentName,
                                    mobile: mobile)
        
        XCTAssertTrue(sut.isValidPasswordLength())
    }
    
    func testUserPassword_passwordAndRepeatPasswordMustMatch() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    departmentName: departmentName,
                                    mobile: mobile)
        
        XCTAssertTrue(sut.doPasswordsMatch())
    }
    
    func testUserPassword_shouldPassIfPasswordIsValid() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    departmentName: departmentName,
                                    mobile: mobile)
        
        XCTAssertTrue(sut.isValidPassword())
    }
    
    func testDepartName_shouldPassIfValidDepartmentName() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    departmentName: departmentName,
                                    mobile: mobile)
        
        XCTAssertTrue(sut.isValidDepartment())
    }
    func testUserMobile_shouldPassIfValidMobile() {
        sut = UserRegistrationModel(firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    departmentName: departmentName,
                                    mobile: mobile)
        
        XCTAssertTrue(sut.isValidMobile())
    }


}
