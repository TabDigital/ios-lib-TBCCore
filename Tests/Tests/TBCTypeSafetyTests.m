//  Copyright (c) 2014 Tabcorp. All rights reserved.

#import <XCTest/XCTest.h>

#import <TBCCore/TBCTypeSafety.h>

@protocol TBCTypeSafetyTestProtocolA <NSObject> @end
@protocol TBCTypeSafetyTestProtocolB <NSObject> @end
@protocol TBCTypeSafetyTestProtocolDerivedFromA <NSObject> @end

@interface TBCTypeSafetyTestClassA : NSObject <TBCTypeSafetyTestProtocolA> @end
@implementation TBCTypeSafetyTestClassA @end

@interface TBCTypeSafetyTestClassB : NSObject @end
@implementation TBCTypeSafetyTestClassB @end

@interface TBCTypeSafetyTestClassDerivedFromA : TBCTypeSafetyTestClassA <TBCTypeSafetyTestProtocolDerivedFromA> @end
@implementation TBCTypeSafetyTestClassDerivedFromA @end



@interface TBCTypeSafetyTests : XCTestCase
@end

@implementation TBCTypeSafetyTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testEnsureClass {
    TBCTypeSafetyTestClassA *classA = [[TBCTypeSafetyTestClassA alloc] init];
    TBCTypeSafetyTestClassDerivedFromA *derived = [[TBCTypeSafetyTestClassDerivedFromA alloc] init];
    
    XCTAssertEqual(classA, TBCEnsureClass(TBCTypeSafetyTestClassA, classA), @"ClassA ensures as ClassA");
    XCTAssertNil(TBCEnsureClass(TBCTypeSafetyTestClassB, classA), @"ClassA not ensure as ClassB");
    XCTAssertEqual(derived, TBCEnsureClass(TBCTypeSafetyTestClassA, derived), @"ClassDerivedFromA ensures as ClassA");
}

- (void)testEnsureSpecificTypes {
    NSArray * const array = @[];
    XCTAssertEqual(array, TBCEnsureNSArray(array), @"NSArray ensures as NSArray");
    
    NSDictionary * const dictionary = @{};
    XCTAssertEqual(dictionary, TBCEnsureNSDictionary(dictionary), @"NSDictionary ensures as NSDictionary");

    NSNumber * const number = @(1);
    XCTAssertEqual(number, TBCEnsureNSNumber(number), @"NSNumber ensures as NSNumber");

    NSString * const string = @"Hello World";
    XCTAssertEqual(string, TBCEnsureNSString(string), @"NSString ensures as NSString");
}

- (void)testEnsureIncorrectSpecificTypes {
    TBCTypeSafetyTestClassA *classA = [[TBCTypeSafetyTestClassA alloc] init];
    XCTAssertNil(TBCEnsureNSArray(classA), @"ClassA not ensure as NSArray");
    XCTAssertNil(TBCEnsureNSDictionary(classA), @"ClassA not ensure as NSDictionary");
    XCTAssertNil(TBCEnsureNSNumber(classA), @"ClassA not ensure as NSNumber");
    XCTAssertNil(TBCEnsureNSString(classA), @"ClassA not ensure as NSString");
}

- (void)testEnsureDerivedSpecificTypes {
    NSMutableArray * const array = [[NSMutableArray alloc] init];
    XCTAssertEqual(array, TBCEnsureNSArray(array), @"NSMutableArray ensures as NSArray");
    
    NSMutableDictionary * const dictionary = [[NSMutableDictionary alloc] init];
    XCTAssertEqual(dictionary, TBCEnsureNSDictionary(dictionary), @"NSMutableDictionary ensures as NSDictionary");
    
    NSMutableString * const string = [[NSMutableString alloc] init];
    XCTAssertEqual(string, TBCEnsureNSString(string), @"NSMutableString ensures as NSString");
}

- (void)testEnsureNSArrayNotEmpty {
    NSArray * const emptyArray = @[];
    NSArray * const nonEmptyArray = @[@""];
    NSMutableArray * const nonEmptyMutableArray = [NSMutableArray arrayWithArray:@[@""]];

    XCTAssertNil(TBCEnsureNSArrayNotEmpty(emptyArray), @"emptyArray not ensure as not empty");
    XCTAssertEqual(nonEmptyArray, TBCEnsureNSArrayNotEmpty(nonEmptyArray), @"nonEmptyArray ensure as not empty");
    XCTAssertEqual(nonEmptyMutableArray, TBCEnsureNSArrayNotEmpty(nonEmptyMutableArray), @"nonEmptyMutableArray ensure as not empty");
    XCTAssertNil(TBCEnsureNSArrayNotEmpty([[NSObject alloc] init]), @"NSObject not ensure as not empty array");
}

- (void)testEnsureNSNotNull {
    NSNull *null = [NSNull null];
    NSObject *notNull = [[NSObject alloc] init];
    
    XCTAssertNil(TBCEnsureNotNSNull(null), @"null not ensure as not null");
    XCTAssertEqual(notNull, TBCEnsureNotNSNull(notNull), @"notNull ensure as not null");
}

- (void)testEnsureProtocol {
    TBCTypeSafetyTestClassA *classA = [[TBCTypeSafetyTestClassA alloc] init];
    TBCTypeSafetyTestClassDerivedFromA *derived = [[TBCTypeSafetyTestClassDerivedFromA alloc] init];
    
    XCTAssertEqual(classA, TBCEnsureProtocol(TBCTypeSafetyTestProtocolA, classA), @"ClassA ensure as conforming to ProtocolA");
    XCTAssertNil(TBCEnsureProtocol(TBCTypeSafetyTestProtocolB, classA), @"ClassA not ensure as conforming to ProtocolB");
    XCTAssertEqual(derived, TBCEnsureProtocol(TBCTypeSafetyTestProtocolA, derived), @"ClassDerivedFromA ensure as conforming to ProtocolA");
    XCTAssertEqual(derived, TBCEnsureProtocol(TBCTypeSafetyTestProtocolDerivedFromA, derived), @"ClassDerivedFromA ensure as conforming to ProtocolDerivedFromA");
}

- (void)testAssertClass {
    TBCTypeSafetyTestClassA *classA = [[TBCTypeSafetyTestClassA alloc] init];
    TBCTypeSafetyTestClassDerivedFromA *derived = [[TBCTypeSafetyTestClassDerivedFromA alloc] init];
    
    XCTAssertEqual(classA, TBCAssertClass(TBCTypeSafetyTestClassA, classA), @"ClassA ensures as ClassA");
    XCTAssertThrowsSpecificNamed(TBCAssertClass(TBCTypeSafetyTestClassB, classA), NSException, NSInternalInconsistencyException, @"ClassA not ensure as ClassB");
    XCTAssertEqual(derived, TBCAssertClass(TBCTypeSafetyTestClassA, derived), @"ClassDerivedFromA ensures as ClassA");
    XCTAssertThrowsSpecificNamed(TBCAssertClass(TBCTypeSafetyTestClassA, nil), NSException, NSInternalInconsistencyException, @"nil asserts");
}

- (void)testAssertClassOrNil {
    TBCTypeSafetyTestClassA *classA = [[TBCTypeSafetyTestClassA alloc] init];
    TBCTypeSafetyTestClassDerivedFromA *derived = [[TBCTypeSafetyTestClassDerivedFromA alloc] init];
    
    XCTAssertEqual(classA, TBCAssertClassOrNil(TBCTypeSafetyTestClassA, classA), @"ClassA ensures as ClassA");
    XCTAssertThrowsSpecificNamed(TBCAssertClassOrNil(TBCTypeSafetyTestClassB, classA), NSException, NSInternalInconsistencyException, @"ClassA not ensure as ClassB");
    XCTAssertEqual(derived, TBCAssertClassOrNil(TBCTypeSafetyTestClassA, derived), @"ClassDerivedFromA ensures as ClassA");
    XCTAssertNil(TBCAssertClassOrNil(TBCTypeSafetyTestClassA, nil), @"nil does not assert");
}

@end
