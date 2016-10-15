//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <XCTest/XCTest.h>

#import <TBCCore/TBCCore.h>


@protocol XXXObserver <NSObject>
@property (nonatomic,copy,nonnull,readonly) NSString *identifier;
@end

@interface XXXObserver : NSObject<XXXObserver>
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithIdentifier:(NSString *)identifier;
@property (nonatomic,copy,nonnull,readonly) NSString *identifier;
@end
@implementation XXXObserver
- (instancetype)initWithIdentifier:(NSString *)identifier {
    if ((self = [super init])) {
        _identifier = identifier.copy;
    }
    return self;
}
@end


@interface TBCObserverCollectionTests : XCTestCase
@end

@implementation TBCObserverCollectionTests

- (void)testSimple {
    TBCObserverCollection<id<XXXObserver>> * const observers = [[TBCObserverCollection alloc] initWithCapacity:0];

    XXXObserver * const o1 = [[XXXObserver alloc] initWithIdentifier:@"1"];
    [observers addObserver:o1];

    NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

    [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
        [notifiedObservers addObject:observer.identifier];
    }];

    XCTAssertEqualObjects(notifiedObservers, (@[ @"1" ]));
}

- (void)testAdditionDuringMutation {
    TBCObserverCollection<id<XXXObserver>> * const observers = [[TBCObserverCollection alloc] initWithCapacity:0];

    XXXObserver * const o1 = [[XXXObserver alloc] initWithIdentifier:@"1"];
    [observers addObserver:o1];

    XXXObserver * __block o2 = nil;

    {
        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
            if ([observer.identifier isEqualToString:@"1"]) {
                o2 = [[XXXObserver alloc] initWithIdentifier:@"2"];
                [observers addObserver:o2];
            }
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ @"1" ]));
    }

    {
        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ @"1", @"2" ]));
    }
}

- (void)testRemovalDuringMutationBeforeNotification {
    TBCObserverCollection<id<XXXObserver>> * const observers = [[TBCObserverCollection alloc] initWithCapacity:0];

    XXXObserver * const o1 = [[XXXObserver alloc] initWithIdentifier:@"1"];
    [observers addObserver:o1];

    XXXObserver * const o2 = [[XXXObserver alloc] initWithIdentifier:@"2"];
    [observers addObserver:o2];

    {
        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
            if ([observer.identifier isEqualToString:@"1"]) {
                [observers removeObserver:o2];
            }
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ @"1" ]));
    }

    {
        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ @"1" ]));
    }
}

- (void)testRemovalDuringMutationAfterNotification {
    TBCObserverCollection<id<XXXObserver>> * const observers = [[TBCObserverCollection alloc] initWithCapacity:0];

    XXXObserver * const o1 = [[XXXObserver alloc] initWithIdentifier:@"1"];
    [observers addObserver:o1];

    XXXObserver * const o2 = [[XXXObserver alloc] initWithIdentifier:@"2"];
    [observers addObserver:o2];

    {
        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
            if ([observer.identifier isEqualToString:@"2"]) {
                [observers removeObserver:o1];
            }
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ @"1", @"2" ]));
    }

    {
        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ @"2" ]));
    }
}

- (void)testAutomaticRemovalDuringMutationBeforeNotification {
    TBCObserverCollection<id<XXXObserver>> * const observers = [[TBCObserverCollection alloc] initWithCapacity:0];

    XXXObserver * const o1 = [[XXXObserver alloc] initWithIdentifier:@"1"];
    [observers addObserver:o1];

    NSMutableArray<id<XXXObserver>> * const o2Holder = [[NSMutableArray alloc] initWithCapacity:1];

    {
        XXXObserver * const o2 = [[XXXObserver alloc] initWithIdentifier:@"2"];
        [observers addObserver:o2];
        [o2Holder addObject:o2];
    }

    {
        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
            if ([observer.identifier isEqualToString:@"1"]) {
                [o2Holder removeAllObjects];
            }
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ @"1" ]));
    }

    {
        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ @"1" ]));
    }
}

- (void)testAutomaticRemovalDuringMutationAfterNotification {
    TBCObserverCollection<id<XXXObserver>> * const observers = [[TBCObserverCollection alloc] initWithCapacity:0];

    XXXObserver * __block o1 = [[XXXObserver alloc] initWithIdentifier:@"1"];
    [observers addObserver:o1];

    XXXObserver * const o2 = [[XXXObserver alloc] initWithIdentifier:@"2"];
    [observers addObserver:o2];

    {
        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
            if ([observer.identifier isEqualToString:@"2"]) {
                o1 = nil;
            }
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ @"1", @"2" ]));
    }

    {
        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ @"2" ]));
    }
}

- (void)testTokenBasedObservation {
    TBCObserverCollection<id<XXXObserver>> * const observers = [[TBCObserverCollection alloc] initWithCapacity:0];

    XXXObserver * const o1 = [[XXXObserver alloc] initWithIdentifier:@"1"];

    @autoreleasepool {
        id<TBCObserverCollectionToken> token = [observers observationTokenWithObserver:o1];

        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ @"1" ]));

        token = nil;
    }

    {
        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ ]));
    }

    @autoreleasepool {
        id<TBCObserverCollectionToken> token = [observers observationTokenWithObserver:o1];

        NSMutableArray<NSString *> * const notifiedObservers = [[NSMutableArray alloc] initWithCapacity:1];

        [observers notifyObserversWithBlock:^(id<XXXObserver> __nonnull const observer) {
            [notifiedObservers addObject:observer.identifier];
        }];

        XCTAssertEqualObjects(notifiedObservers, (@[ @"1" ]));

        token = nil;
    }
}

@end
