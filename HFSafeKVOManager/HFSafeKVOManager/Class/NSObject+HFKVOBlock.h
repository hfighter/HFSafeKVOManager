//
//  NSObject+HFKVOBlock.h
//  HFSafeKVOManager
//
//  Created by hui hong on 2018/11/30.
//  Copyright © 2018 hui hong. All rights reserved.
//

#import <Foundation/Foundation.h>

extern char *const kHFKVOBlockKey;

typedef void(^HFKVOBlock)(NSString *keyPath, id object, NSDictionary *changes);

@interface NSObject (HFKVOBlock)

- (void)hf_addObserver:(id)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context block:(HFKVOBlock)block;

@end

