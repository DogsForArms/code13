//
//  Helpers.swift
//  code13
//
//  Created by Ethan Sherr on 12/23/15.
//  Copyright © 2015 Ethan Sherr. All rights reserved.
//

import Foundation
import XCTest

func waitForAppToSettle( settleTime: NSTimeInterval = 8, maxSettleTime: NSTimeInterval = 60 )
{
    waitToSettle(
        {  () -> String in
            return XCUIApplication().uniqueishString();
        }, withSettleTime: settleTime,
        alternateEqualityBlock: nil,
        andMaximumSettle: maxSettleTime,
        couldNotSettleError: "Application was not settled after \(maxSettleTime) seconds")
}

public func waitToSettle<T: Equatable>(   getSettledValue:() -> T,
    withSettleTime settleTime: NSTimeInterval = 5,
    alternateEqualityBlock:((T, T) -> Bool)? = nil,
    andMaximumSettle maxSettle: NSTimeInterval = 60,
    couldNotSettleError message: String? = nil)
{
    let sleepInterval: NSTimeInterval = 0.2
    
    let startTime = NSDate().timeIntervalSince1970
    var lastSettleAttemptTime = startTime
    var lastSettledValue = getSettledValue()
    
    
    func settleLoop()
    {
        let currentTime = NSDate().timeIntervalSince1970
        let currentSettledValue = getSettledValue()
        let isSettled = (alternateEqualityBlock != nil) ?
            alternateEqualityBlock!(currentSettledValue, lastSettledValue) :
            currentSettledValue == lastSettledValue
        
        let timeSinceLastSettleAttempt = currentTime - lastSettleAttemptTime
        
        if isSettled && timeSinceLastSettleAttempt >= settleTime
        {
            print("✅ total time \(currentTime - startTime)s")
        }
        else
            if currentTime - startTime > maxSettle
            {
                print("❌ could not settle in \(maxSettle)s")
                XCTFail((message != nil) ?  message! :
                    "Could not settle on condition: \(getSettledValue)")
            }
            else
            {
                
                if !isSettled
                {
                    print("🚷 change detected, Reset")
                    lastSettledValue = currentSettledValue
                    lastSettleAttemptTime = currentTime
                }
                else
                {
                    print("⏸ \(Int(100*timeSinceLastSettleAttempt/settleTime))% - (\(Int(timeSinceLastSettleAttempt))s/\(settleTime)s)")
                }
                
                wait(sleepInterval)
                settleLoop()
        }
    }
    settleLoop()
}

func wait(duration: Double)
{
    NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: duration))
}

extension XCUIElement
{
    func uniqueishString() -> String
    {
        let rectAndSubtreeRegex = try! NSRegularExpression(
            pattern: "Attributes(.*?)Path\\sto\\selement",
            options: [.CaseInsensitive, .DotMatchesLineSeparators] )
        
        let replaceMemoryAddressRegex = try! NSRegularExpression(
            pattern: "(0x.*?):",
            options: [])
        
        let debugDescription = self.debugDescription
        let entireStringRange = NSRange(location: 0, length: debugDescription.characters.count)
        
        //throws if no match found
        let rectAndSubtreeMatch:NSTextCheckingResult! = rectAndSubtreeRegex.firstMatchInString(
            debugDescription,
            options: [],
            range: entireStringRange)
        
        let rectAndSubtree = (debugDescription as NSString).substringWithRange(rectAndSubtreeMatch.rangeAtIndex(1))
        let rectAndSubtreeRange = NSRange(location: 0, length: rectAndSubtree.characters.count)
        
        let removedMemoryAddresses = replaceMemoryAddressRegex.stringByReplacingMatchesInString(
            rectAndSubtree,
            options: [],
            range: rectAndSubtreeRange,
            withTemplate: "👉")
        
        return removedMemoryAddresses
    }
}