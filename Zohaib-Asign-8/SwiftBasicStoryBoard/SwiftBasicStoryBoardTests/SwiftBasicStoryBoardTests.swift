//
//  SwiftBasicStoryBoardTests.swift
//  SwiftBasicStoryBoardTests
//
//  Created by Zohaib Aziz on 13/06/2017.
//  Copyright © 2017 NISUM. All rights reserved.
//

import XCTest
@testable import SwiftBasicStoryBoard
import CoreData


class SwiftBasicStoryBoardTests: XCTestCase {
    
    let coreDataFetch = DataFetch()

    override func setUp() {
        super.setUp()
        continueAfterFailure = true

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
    
    func testCoreDataBackgroundLoad()   {
        let backgroundDataCoordinator = BackgroundCoordinator()
        let backgroundDataCoordinatorExpectation = expectation(description: "BackgroundDataCoordinator loads Item in background")
        backgroundDataCoordinator.requestAndLoadEntities(entityType: EntityType.Item) {
            (success:Bool) in
            XCTAssert(success)
            backgroundDataCoordinatorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) {
            error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testCoreDataFetchEntityById()  {
        //Test happy path:
        let testId = 1
        var item:Item? = coreDataFetch.fetchEntity(byId: NSNumber.init(value: testId))
        XCTAssert(Int(item!.id) == testId)
        //Test no object path:
        item = coreDataFetch.fetchEntity(byId: NSNumber.init(value: 123))
        XCTAssertNil(item)
        // TODO: test error path:
        let entityBase:EntityBase? = coreDataFetch.fetchEntity(byId: NSNumber.init(value: 123))
        XCTAssertNil(entityBase)
    }
    
    func testCoreDataFetchEntityByName()  {
        //Test happy path:
        let testName = "Item 1"
        var item:Item? = coreDataFetch.fetchEntity(byName: testName)
        XCTAssert(item?.name == testName)
        //Test no object path:
        item = coreDataFetch.fetchEntity(byName: "Something bogus")
        XCTAssertNil(item)
        // TODO: test error path:
        let entityBase:EntityBase? = coreDataFetch.fetchEntity(byId: NSNumber.init(value: 123))
        XCTAssertNil(entityBase)
    }
    
    func testCoreDataFetchedResultsController() {
        var fetchedResultsController: NSFetchedResultsController<Item>!
        fetchedResultsController = coreDataFetch.getFetchedResultsController()
        do {
            try fetchedResultsController.performFetch()
            XCTAssert((fetchedResultsController.fetchedObjects?.count)! > 0)
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }

    
}
