//
//  code13UITests.swift
//  code13UITests
//
//  Created by Ethan Sherr on 12/22/15.
//  Copyright © 2015 Ethan Sherr. All rights reserved.
//

import XCTest

class code13UITests: XCTestCase {
    
    let app = XCUIApplication()
    
    func cellContainingInteger( value: Int) -> XCUIElement
    {
        return app.cells.containingPredicate(NSPredicate(format: "label == 'cell \(value)'")).element
    }
    func cellForIndex( index: Int) -> XCUIElement
    {
        return app.cells.elementBoundByIndex( UInt(index) )
    }
    
    
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app.launch()
        
        

    }
    
    override func tearDown()
    {
        app.terminate()
        super.tearDown()
    }
    
    func testRandomAddBroken()
    {
        let addThingsRandomlyButton = app.buttons["addThingsRandomlyButton"]
        addThingsRandomlyButton.tap()
        
        let firstCell = cellForIndex(0)
        
        expectationForPredicate(NSPredicate(block: { (observedObj, _: [String : AnyObject]?) -> Bool in
            return (observedObj as! XCUIElement).exists
        }), evaluatedWithObject: firstCell, handler: nil)
        waitForExpectationsWithTimeout(10, handler: nil)
    
        firstCell.tap() //should fail! code13 (if it doesn't fail, incrase setNumberOfThingsToAdd value
        let alertAlright = app.buttons["Alright"]
        alertAlright.waitForExistence()
        alertAlright.tap()
        
        //keep going until you find the problem...  yes this is an infinite loop
        testRandomAddBroken()
    }
    
    func testRandomAddFixed()
    {
        let addThingsRandomlyButton = app.buttons["addThingsRandomlyButton"]
        addThingsRandomlyButton.tap()
        
        let firstCell = cellForIndex(0)
        
        expectationForPredicate(NSPredicate(block: { (observedObj, _: [String : AnyObject]?) -> Bool in
            return (observedObj as! XCUIElement).exists
        }), evaluatedWithObject: firstCell, handler: nil)
        waitForExpectationsWithTimeout(10, handler: nil)
        
        waitForAppToSettle(7) //7 is a generous amount of time to wait.
        
        firstCell.tap() //works!
        let alertAlright = app.buttons["Alright"]
        alertAlright.waitForExistence()
        alertAlright.tap()
        
        testRandomAddBroken()
    }
    
//    func removeOneAtATimeSometimesFails() {
//        
//        let max = Int(app.cells.count - 1)
//        (1..<max).forEach({
//            print($0)
//            let cell = cellContainingInteger($0)
//            cell.buttons["cellDeleteButton"].tap()
//            
//            expectationForPredicate(NSPredicate(block: { (observed, _:[String : AnyObject]?) -> Bool in
//                return !(observed as! XCUIElement).exists
//            }), evaluatedWithObject: cell, handler: nil)
//            waitForExpectationsWithTimeout(10, handler: nil)
//            
//        })
//    }
    
}
