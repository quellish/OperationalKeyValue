//
//  SampleOperation.m
//  OperationalKeyValue
//
//  Created by Dan Zinngrabe on 9/15/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "SampleOperation.h"

@interface SampleOperation ()
@property (atomic, readwrite, getter=isExecuting) BOOL executing;
@property (atomic, readwrite, getter=isFinished)  BOOL finished;
@end

@implementation SampleOperation
@synthesize executing;
@synthesize finished;

- (void) main {
    if (![self isCancelled]){
        [self setExecuting:YES];
        [self setFinished:NO];
        
        // Something would happen here.
        
        [self setFinished:YES];
        [self setExecuting:NO];
    }
}

- (void) start {
    [self main];
}

- (BOOL) isConcurrent {
    return YES;
}

// For the truly paranoid, to send a notification for the *keyPath* isFinished,
// register "finished" as a dependency. This is the correct way to remain KVO compliant when sending
// isFinished.

+ (NSSet *) keyPathsForValuesAffectingIsFinished {
    NSSet   *result = [NSSet setWithObject:@"finished"];
    return result;
}

+ (NSSet *) keyPathsForValuesAffectingIsExecuting {
    NSSet   *result = [NSSet setWithObject:@"executing"];
    return result;
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
