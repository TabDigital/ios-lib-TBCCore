//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>


@protocol TBCObserverCollectionToken <NSObject>
- (void)invalidate;
@end

@interface TBCObserverCollection<ObserverType> : NSObject

- (instancetype __nonnull)init;
- (instancetype __nonnull)initWithCapacity:(NSUInteger)capacity NS_DESIGNATED_INITIALIZER;

- (id<TBCObserverCollectionToken> __nonnull)observationTokenWithObserver:(ObserverType __nonnull)observer __attribute__((warn_unused_result));

- (void)addObserver:(ObserverType __nonnull)observer;
- (void)removeObserver:(ObserverType __nonnull)observer;

- (void)compact;

- (void)notifyObserversWithBlock:(void(^ __nonnull)(ObserverType __nonnull observer))block;

@end
