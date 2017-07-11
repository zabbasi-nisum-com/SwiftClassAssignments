//
//  SwiftBasicStoryBoardUITests.swift
//  SwiftBasicStoryBoardUITests
//
//  Created by Zohaib Aziz on 13/06/2017.
//  Copyright © 2017 NISUM. All rights reserved.
//

import XCTest

class SwiftBasicStoryBoardUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    let testItemName = "Test item"
    let testLocationName = "My test location"
    let testBinName = "My test bin"
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
      XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let enterNameTextField = app.textFields["Enter Name "]
        enterNameTextField.tap()
        enterNameTextField.typeText("zoha")
        
        let enterQtyTextField = app.textFields["Enter Qty "]
        enterQtyTextField.typeText("ib")
        enterQtyTextField.tap()
        enterQtyTextField.tap()
        enterQtyTextField.typeText("123")
        app.buttons["LocationInput"].tap()
        
        let locationNameTextField = app.alerts["Create Location"].collectionViews.textFields["Location name"]
        locationNameTextField.tap()
        locationNameTextField.typeText("Loc-")
        enterQtyTextField.typeText("1")
        app.otherElements.containing(.navigationBar, identifier:"My First App").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        enterQtyTextField.tap()
        app.textFields[" < Select Location >"].tap()
        app.pickerWheels["Loc-1"].press(forDuration: 1.4);
        app.buttons["Print"].tap()
        
        
        
    }
    
    func testSelectLocation()    {
        createLocation(locationName: testLocationName)
        createLocation(locationName: "Another Location")
        selectLocation()
    }
    
    func testSelectBin()    {
        createBin(binName: testBinName)
        createBin(binName: "Another Bin")
        selectBin()
    }
    func selectandAddLocation()   {
        
    }
    
    func selectLocation()   {
        print(app.debugDescription)
        let textField = app.textFields["Location Input"]
        textField.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: testLocationName)
        waitForElementValueToUpdate(element: textField, expectedValue: testLocationName)
        XCTAssert(app.textFields["Location Input"].value as! String == testLocationName)
    }
    
    func selectBin()   {
        let textField = app.textFields["Bin Input"]
        textField.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: testBinName)
        waitForElementValueToUpdate(element: textField, expectedValue: testBinName)
        XCTAssert(app.textFields["Bin Input"].value as! String == testBinName)
    }
    
    func testCreateItem() {
        print(app.debugDescription)
        let itemTextField = app.textFields["Item Name Input"]
        itemTextField.tap()
        itemTextField.typeText(testItemName)
        
        let qtyTextField = app.textFields["Item Quantity Input"]
        qtyTextField.tap()
        qtyTextField.typeText("13")
        createLocation(locationName: testLocationName)
        createBin(binName: testBinName)
        app.buttons["Save Button"].tap()
        XCTAssert((itemTextField.value as! String).isEmpty)
    }
    
    func createLocation(locationName:String)    {
        app.buttons["Add Location Button"].tap()
        let alert = app.alerts["Create Location"]
        let binTextField = alert.textFields["Location Name Input"]
        binTextField.typeText(locationName)
        alert.buttons["OK"].tap()
        XCTAssert(app.textFields["Location Input"].value as! String == locationName)
    }
    
    func createBin(binName:String)    {
        app.buttons["Add Bin Button"].tap()
        let alert = app.alerts["Create Bin"]
        let binTextField = alert.textFields["Bin Name Input"]
        binTextField.typeText(binName)
        alert.buttons["OK"].tap()
        XCTAssert(app.textFields["Bin Input"].value as! String == binName)
    }
    
    func waitForElementToAppear(_ element: XCUIElement) {
        let predicate = NSPredicate(format: "exists == true")
        let _ = expectation(for: predicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 1)
    }
    
    func waitForElementToDisappear(_ element: XCUIElement) {
        let predicate = NSPredicate(format: "exists == false")
        let _ = expectation(for: predicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 1)
    }
    
    func waitForElementValueToUpdate(element: XCUIElement, expectedValue: String) {
        let predicate = NSPredicate(format: "value == %@", expectedValue)
        let _ = expectation(for: predicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 1)
    }

    
}
