//
//  HFSafeKVOManager.m
//  HFSafeKVOManager
//
//  Created by hui hong on 2018/11/30.
//  Copyright © 2018 hui hong. All rights reserved.
//

#import "HFSafeKVOManager.h"
#import <objc/runtime.h>

char *const kHFSafeKVOManagerAssociatedObjectKey = "kHFSafeKVOManagerAssociatedObjectKey";

@interface HFSafeKVOManager ()

// 被观察对象
@property (nonatomic, strong) id object;
// 观察者
@property (nonatomic, weak) id observer;
@property (nonatomic, copy) NSString *keyPath;

@end

@implementation HFSafeKVOManager

- (void)dealloc {
    if (self.object && self.keyPath) {
        [self.object removeObserver:self forKeyPath:self.keyPath];
    }
    objc_setAssociatedObject(self, kHFKVOBlockKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void)object:(id)object addObserver:(id)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options withBlock:(HFKVOBlock)block {
    if (!object || !observer || !keyPath) {
        return;
    }
    HFSafeKVOManager *manager = [HFSafeKVOManager new];
    manager.object = object;
    manager.observer = observer;
    manager.keyPath = keyPath;
    objc_setAssociatedObject(manager.observer, kHFSafeKVOManagerAssociatedObjectKey, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [object hf_addObserver:manager forKeyPath:keyPath options:options context:nil block:^(NSString *keyPath, id object, NSDictionary *changes) {
        if (block) {
            block(keyPath, object, changes);
        }
    } ];
}

+ (void)removeObserver:(id)observer {
    if (!observer) {
        return;
    }
    HFSafeKVOManager *manager = objc_getAssociatedObject(observer, kHFSafeKVOManagerAssociatedObjectKey);
    if (!manager) {
        return;
    }
    [manager.object removeObserver:manager forKeyPath:manager.keyPath];
    manager.object = nil;
    manager.keyPath = nil;
}

@end
