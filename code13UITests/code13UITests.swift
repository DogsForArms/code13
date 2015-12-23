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
    
    //test
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
    
    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
    
    func testRandomAdd(){
        let addThingsRandomlyButton = app.buttons["addThingsRandomlyButton"]
        addThingsRandomlyButton.tap()
        
        let firstCell = cellForIndex(0)
        
        expectationForPredicate(NSPredicate(block: { (observedObj, _: [String : AnyObject]?) -> Bool in
            return (observedObj as! XCUIElement).exists
        }), evaluatedWithObject: firstCell, handler: nil)
        waitForExpectationsWithTimeout(10, handler: nil)
        
        
        firstCell.tap()
        
    }
    
    func testExample() {
        
        let max = Int(app.cells.count - 1)
        (1..<max).forEach({
            print($0)
            let cell = cellContainingInteger($0)
            cell.buttons["cellDeleteButton"].tap()
            
            expectationForPredicate(NSPredicate(block: { (observed, _:[String : AnyObject]?) -> Bool in
                return !(observed as! XCUIElement).exists
            }), evaluatedWithObject: cell, handler: nil)
            waitForExpectationsWithTimeout(10, handler: nil)
            
        })
    }
    
}
