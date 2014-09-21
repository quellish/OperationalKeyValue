//
//  ViewController.m
//  OperationalKeyValue
//
//  Created by Dan Zinngrabe on 9/15/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "ViewController.h"
#import "SampleOperation.h"

@interface ViewController ()
//@property (nonatomic, strong)   NSOperation *operation;
@end

@implementation ViewController
//@synthesize operation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SampleOperation *sample = [[SampleOperation alloc] init];

    // you can observe these  if you really want, but there's no point.
    // with `NSOperation` dependencies, it observes `isExecuting` and `isFinished`,
    // not `executing` and `finished`
    //
    // [sample addObserver:self forKeyPath:@"executing" options:[self observationOptions] context:(void *)self];
    // [sample addObserver:self forKeyPath:@"finished" options:[self observationOptions] context:(void *)self];

    // I'm not sure why you'd want to keep a strong reference to the operation. If anything, you
    // might keep a weak reference, but definitely not a strong reference.
    //
    // [self setOperation:sample];
    
    [[NSOperationQueue mainQueue] addOperation:sample];

    SampleOperation *sample2 = [[SampleOperation alloc] init];
    [sample2 addDependency:sample];

    // please note, if you comment out the `isExecuting` and `isFinished` custom setters
    // you'll never see this second operation start.

    [[NSOperationQueue mainQueue] addOperation:sample2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSKeyValueObservingOptions) observationOptions {
    return (NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld);
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == (__bridge void *)self){
        NSLog(@"%@ changed: %@", keyPath, change);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
