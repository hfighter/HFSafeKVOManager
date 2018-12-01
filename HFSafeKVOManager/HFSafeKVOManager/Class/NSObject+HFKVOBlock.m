//
//  NSObject+HFKVOBlock.m
//  HFSafeKVOManager
//
//  Created by hui hong on 2018/11/30.
//  Copyright © 2018 hui hong. All rights reserved.
//

#import "NSObject+HFKVOBlock.h"
#import <objc/runtime.h>

char *const kHFKVOBlockKey = "kHFKVOBlockKey";

@interface NSObject ()

@property (nonatomic, copy) HFKVOBlock block;

@end

@implementation NSObject (HFKVOBlock)

- (void)hf_addObserver:(id)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context block:(HFKVOBlock)block {
    if (!observer || !keyPath) {
        return;
    }
    if (block) {
        objc_setAssociatedObject(observer, kHFKVOBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    HFKVOBlock block = objc_getAssociatedObject(self, kHFKVOBlockKey);
    if (block) {
        block(keyPath, object, change);
    }
}

@end
