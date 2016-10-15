//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCObserverCollection.h"


@interface TBCObserverCollectionToken : NSObject<TBCObserverCollectionToken>
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithObserverCollection:(TBCObserverCollection * __nonnull)collection observer:(id)observer NS_DESIGNATED_INITIALIZER;
@property (nonatomic,weak,nullable,readonly) TBCObserverCollection *collection;
@property (nonatomic,weak,nullable,readonly) id observer;
@end

@implementation TBCObserverCollectionToken
- (instancetype)initWithObserverCollection:(TBCObserverCollection * __nonnull)collection observer:(id)observer {
    if ((self = [super init])) {
        _collection = collection;
        _observer = observer;
    }
    return self;
}
- (void)dealloc {
    [self invalidate];
}
- (void)invalidate {
    id const observer = _observer;
    _observer = nil;
    if (observer) {
        [_collection removeObserver:observer];
    }
}
@end


@implementation TBCObserverCollection {
@private
    NSPointerArray *_pointerArray;
}

- (instancetype)init {
    return [self initWithCapacity:0];
}
- (instancetype)initWithCapacity:(NSUInteger)capacity {
    if ((self = [super init])) {
        _pointerArray = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsObjectPointerPersonality|NSPointerFunctionsWeakMemory];
    }
    return self;
}


- (NSUInteger)tbc_lastIndexOfObserverInPointerArray:(id __nonnull)observer {
    NSUInteger const pointerArrayCount = _pointerArray.count;
    for (NSUInteger i = pointerArrayCount; i > 0; --i) {
        id const object = [_pointerArray pointerAtIndex:i - 1];
        if (object == observer) {
            return i - 1;
        }
    }
    return NSNotFound;
}


- (id<TBCObserverCollectionToken> __nonnull)observationTokenWithObserver:(id __nonnull)observer {
    TBCObserverCollectionToken * const token = [[TBCObserverCollectionToken alloc] initWithObserverCollection:self observer:observer];
    [self addObserver:observer];
    return token;
}


- (void)addObserver:(id)observer {
    [_pointerArray addPointer:(__bridge void *)observer];
}

- (void)removeObserver:(id)observer {
    NSUInteger const lastIndexOfObserver = [self tbc_lastIndexOfObserverInPointerArray:observer];
    if (lastIndexOfObserver == NSNotFound) {
        return;
    }
    [_pointerArray removePointerAtIndex:lastIndexOfObserver];
}


- (void)compact {
    [_pointerArray compact];
}


- (void)notifyObserversWithBlock:(void (^)(id __nonnull))block {
    // just using -copy seems to hold a retain on the objects
    NSPointerArray * const pointerArrayCopy = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsObjectPointerPersonality|NSPointerFunctionsWeakMemory];
    @autoreleasepool {
        for (id observer in _pointerArray) {
            [pointerArrayCopy addPointer:(__bridge void * _Nullable)(observer)];
        }
    }

    NSUInteger const pointerArrayCount = pointerArrayCopy.count;
    for (NSUInteger i = 0; i < pointerArrayCount; ++i) @autoreleasepool {
        id const observer = [pointerArrayCopy pointerAtIndex:i];
        if (!observer) {
            continue;
        }
        if ([self tbc_lastIndexOfObserverInPointerArray:observer] == NSNotFound) {
            continue;
        }
        block(observer);
    }
}

@end
