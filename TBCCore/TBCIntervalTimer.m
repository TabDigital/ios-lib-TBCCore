//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCIntervalTimer.h"

typedef NS_ENUM(NSUInteger, TBCIntervalTimerState) {
    TBCIntervalTimerNotStarted,
    TBCIntervalTimerRunning,
    TBCIntervalTimerPaused,
};

@implementation TBCIntervalTimer {
@private
    dispatch_queue_t _queue;
    TBCIntervalTimerBlock _block;
    
    TBCIntervalTimerState _state;
    NSTimeInterval _durationOfPreviousChunks;
    NSDate *_chunkStartDate;
}

- (instancetype)initWithBlock:(TBCIntervalTimerBlock)block {
    return [self initWithQueue:nil block:block];
}

- (instancetype)initWithQueue:(dispatch_queue_t)queue block:(TBCIntervalTimerBlock)block {
    NSParameterAssert(block);

    if (!queue) {
        queue = dispatch_get_main_queue();
    }

    self = [super init];
    if (self) {
        _queue = queue;
        _block = [block ?: ^(NSTimeInterval i){} copy];
        
        _state = TBCIntervalTimerNotStarted;
        _durationOfPreviousChunks = 0;
        _chunkStartDate = nil;
    }
    return self;
}

- (void)dealloc {
    if (_state != TBCIntervalTimerNotStarted) {
        [self stop];
    }
}

- (void)start {
    NSAssert(_state == TBCIntervalTimerNotStarted, @"Attempt to start TBCIntervalTimer that is already running");
    _durationOfPreviousChunks = 0;
    [self tbc_beginChunk];
}

- (void)pause {
    NSAssert(_state != TBCIntervalTimerNotStarted, @"Attempt to resume TBCIntervalTimer that was not started");
    
    if (_state == TBCIntervalTimerRunning) {
        [self tbc_endChunk];
    }
}

- (void)resume {
    NSAssert(_state != TBCIntervalTimerNotStarted, @"Attempt to resume TBCIntervalTimer that was not started");
    
    if (_state == TBCIntervalTimerPaused) {
        [self tbc_beginChunk];
    }
}

- (void)stop {
    NSAssert(_state != TBCIntervalTimerNotStarted, @"Attempt to stop TBCIntervalTimer that was not started");

    if (_state == TBCIntervalTimerRunning) {
        [self tbc_endChunk];
    }

    NSTimeInterval resultInterval = _durationOfPreviousChunks;
    _state = TBCIntervalTimerNotStarted;
    
    TBCIntervalTimerBlock sblock = _block;
    dispatch_async(_queue, ^{
        sblock(resultInterval);
    });
}

- (void)tbc_beginChunk {
    NSAssert(_state != TBCIntervalTimerRunning, @"");
    
    _chunkStartDate = [NSDate date];
    _state = TBCIntervalTimerRunning;
}

- (void)tbc_endChunk {
    NSAssert(_state == TBCIntervalTimerRunning, @"");
    
    NSTimeInterval chunkInterval = [[NSDate date] timeIntervalSinceDate:_chunkStartDate];
    _durationOfPreviousChunks += chunkInterval;
    _state = TBCIntervalTimerPaused;
}

@end
