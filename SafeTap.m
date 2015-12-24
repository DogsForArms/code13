//
//  XCUIElement+Extension.m
//  code13
//
//  Created by Ethan Sherr on 12/24/15.
//  Copyright © 2015 Ethan Sherr. All rights reserved.
//

#import "SafeTap.h"
#import <XCTest/XCTest.h>

@implementation SafeTap : NSObject



+(void)tapRecursive:(XCUIElement *)element
{
    @try
    {
        BOOL whatever = element.exists;
        NSLog(@"%@", element.debugDescription);
        [element tap];
    }
    @catch (NSException *codeThirteenException)
    {
        NSLog(@"%@", codeThirteenException);
        NSLog(@"🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉WE CAUGHT IT🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉");
        NSDate *before = [NSDate date];
        [SafeTap wait:5];
        //[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:expectedEnd];
        NSDate *after = [NSDate date];
        
        NSLog(@"a:\t%f ", (after.timeIntervalSince1970 - before.timeIntervalSince1970) );
        
        [SafeTap tapRecursive:element];
    }
    @finally {
        
    }
    
    NSLog(@"👀👀👀👀👀SUCCESSSS👀👀👀👀👀👀");
}

+(void)tapWhile:(XCUIElement *)element
{
    NSException *exception;
    NSTimeInterval interval = 1;
    
    while (true)
    {
        @try
        {
            NSLog(@"%@", element.debugDescription);
            [element tap];
        }
        @catch (NSException *codeThirteenException)
        {
            exception = codeThirteenException;
        }
        @finally
        {
            if (!exception)
            {
                NSLog(@"👀👀👀👀👀SUCCESSSS👀👀👀👀👀👀");
                return;
            }
            else
            {
                exception = nil;
                interval = interval + 1;
                
                NSDate *start = [NSDate date];
                [SafeTap wait:interval];
                
                NSLog(@"waited %f", ([NSDate date].timeIntervalSince1970) - start.timeIntervalSince1970);
                
                NSLog(@"🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉WE CAUGHT IT🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉");
            }
        }
    }
}

+(void)wait:(NSTimeInterval)seconds
{
    NSDate *startDate = [NSDate date];
    while (true) {
        NSDate *endDate = [NSDate date];
        if (endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970 >= seconds)
        {
            break;
        }
    }
}



@end
