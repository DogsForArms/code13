//
//  XCUIElement+Extension.h
//  code13
//
//  Created by Ethan Sherr on 12/24/15.
//  Copyright © 2015 Ethan Sherr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@interface SafeTap : NSObject

+(void)tapRecursive:(XCUIElement *)element;

+(void)tapWhile:(XCUIElement *)element;

+(void)tapCondition:(XCUIElement* )element;


@end
