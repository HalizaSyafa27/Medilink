//
//  OptimalHealthTests.swift
//  OptimalHealthTests
//
//  Created by Chinmaya Sahu on 8/2/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import XCTest
@testable import OptimalHealth

class OptimalHealthTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    /*
    func test_username_placeholder() {
        let login = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInController") as! LogInController
        let _ = login.view
        XCTAssertEqual("Username", login.userNameTf!.placeholder!)
    }

    func testIfLoginButtonHasActionAssigned() {
        //Check if Controller has UIButton property
        let login = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInController") as! LogInController
        let loginButton: UIButton = login.signInBtn
        XCTAssertNotNil(loginButton, "View Controller does not have UIButton property")
        
        // Attempt Access UIButton Actions
        guard let loginButtonActions = loginButton.actions(forTarget: login, forControlEvent: .touchUpInside) else {
            XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
            return
        }
     
        // Assert UIButton has action with a method name
        XCTAssertTrue(loginButtonActions.contains("loginButtonTapped:"))
    }*/
    
}
