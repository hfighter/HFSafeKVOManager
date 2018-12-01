//
//  ViewController.m
//  HFSafeKVOManager
//
//  Created by hui hong on 2018/11/30.
//  Copyright © 2018 hui hong. All rights reserved.
//

#import "ViewController.h"
#import "HFSafeKVOManager.h"

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@end

@implementation Person

@end

@interface ViewController ()

@property (nonatomic, strong) Person *p;

@end

@implementation ViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.p = [Person new];
    [HFSafeKVOManager object:self.p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew withBlock:^(NSString *keyPath, id object, NSDictionary *changes) {
        NSLog(@"keypath is %@, object is %@, changes is %@", keyPath, object, changes);
    }];
    
//    [self.p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.p.name = @"name";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HFSafeKVOManager removeObserver:self];
        });
    });
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    NSLog(@"change is %@", change);
//}

@end
