//  Copyright (c) 2014 Tabcorp. All rights reserved.

#import <XCTest/XCTest.h>

#import <TBCCore/TBCCore.h>

@interface TBCCoreTests : XCTestCase

@end

@implementation TBCCoreTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    XCTAssertNotNil([[TBCCore alloc] init], @"");
}

@end
