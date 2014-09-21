//
//  SampleOperation.m
//  OperationalKeyValue
//
//  Created by Dan Zinngrabe on 9/15/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "SampleOperation.h"

static NSString * const kFinishedKey = @"isFinished";
static NSString * const kExecutingKey = @"isExecuting";

@interface SampleOperation ()
@property (nonatomic, readwrite, getter=isExecuting) BOOL executing;
@property (nonatomic, readwrite, getter=isFinished)  BOOL finished;
@end

@implementation SampleOperation
@synthesize executing = _executing;
@synthesize finished  = _finished;

- (void) main {

    NSLog(@"starting operation");

    // do something asynchronously

    // e.g., we're going to let `main` return, but two seconds later, we'll end this operation

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"finishing operation");

        [self setExecuting:NO];
        [self setFinished:YES];
    });
}

- (void) start {

    if ([self isCancelled]) {
        [self setFinished:YES];
        return;
    }

    [self setExecuting:YES];

    [self main];
}

- (BOOL) isConcurrent {
    return YES;
}

- (void)setExecuting:(BOOL)executing
{
    [self willChangeValueForKey:kExecutingKey];
    _executing = executing;
    [self didChangeValueForKey:kExecutingKey];
}

- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:kFinishedKey];
    _finished = finished;
    [self didChangeValueForKey:kFinishedKey];
}

/***
 
// Don't need to do this, automatic property notifications are already active.
+ (BOOL) automaticallyNotifiesObserversOfFinished {
    return YES;
}

+ (BOOL) automaticallyNotifiesObserversOfExecuting {
    return YES;
}
***/

@end
