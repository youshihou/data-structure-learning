//
//  PriorityQueue.h
//  BinaryTree
//
//  Created by Ankui on 8/5/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BinaryHeap.h"

NS_ASSUME_NONNULL_BEGIN

@interface PriorityQueue : NSObject
+ (instancetype)queue;
+ (instancetype)queueWithComparator:(id<HeapComparator> _Nullable)comparator;
+ (instancetype)queueWithBlock:(NSInteger(^)(id _Nullable, id _Nullable))block;
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)clear;
- (void)enQueue:(id)element;
- (id)deQueue;
- (id)front;

@end

NS_ASSUME_NONNULL_END
