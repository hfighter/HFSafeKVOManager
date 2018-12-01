//
//  HFSafeKVOManager.h
//  HFSafeKVOManager
//
//  Created by hui hong on 2018/11/30.
//  Copyright © 2018 hui hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+HFKVOBlock.h"

extern char *const kHFSafeKVOManagerAssociatedObjectKey;

// 安全的KVO类，只需负责注册，可以不用关注释放;
// 当然也可以手动提前释放
/**
 * 实现方式：通过将observer转移给HFSafeKVOManager来观察，
 * 将HFSafeKVOManager的对象通过关联对象注册到observer中，
 * 监听observer类的生命周期，从而达到及时自动释放
 */
@interface HFSafeKVOManager : NSObject

/**
 添加注册KVO方法
 @param object 被观察的object
 @param observer 观察者类（调用所在类）
 @param keyPath keyPath
 @param options options
 @param block KVO回调，将KVO代理回调转化为block回调，更直观
 */
+ (void)object:(id)object addObserver:(id)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options withBlock:(HFKVOBlock)block;

/**
 移除KVO
 @param observer observer
 */
+ (void)removeObserver:(id)observer;

@end

