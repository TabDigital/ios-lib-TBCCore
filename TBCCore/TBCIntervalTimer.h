//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

typedef void (^TBCIntervalTimerBlock)(NSTimeInterval interval);

@interface TBCIntervalTimer : NSObject

- (instancetype)initWithBlock:(TBCIntervalTimerBlock)block;
- (instancetype)initWithQueue:(dispatch_queue_t)queue block:(TBCIntervalTimerBlock)block NS_DESIGNATED_INITIALIZER;

- (void)start;
- (void)pause;
- (void)resume;
- (void)stop;

@end
