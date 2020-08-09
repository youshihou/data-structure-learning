//
//  PriorityQueue.m
//  BinaryTree
//
//  Created by Ankui on 8/5/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "PriorityQueue.h"

@interface PriorityQueue () {
    BinaryHeap *_heap;
    NSInteger (^_block)(id, id);
    id<HeapComparator> _comparator;
}
@end

@implementation PriorityQueue
- (instancetype)init {
    if (self = [super init]) {
        _heap = [BinaryHeap heap];
    }
    return self;
}

+ (instancetype)queue {
    return [[self alloc] init];
}
+ (instancetype)queueWithComparator:(id<HeapComparator>)comparator {
    PriorityQueue *queue = [self queue];
    queue->_comparator = comparator;
    queue->_heap = [BinaryHeap heapWithComparator:comparator];
    return queue;
}
+ (instancetype)queueWithBlock:(NSInteger (^)(id _Nullable, id _Nullable))block {
    PriorityQueue *queue = [self queue];
    queue->_block = block;
    queue->_heap = [BinaryHeap heapWithBlock:block];
    return queue;
}
- (NSUInteger)size {
    return [_heap size];
}
- (BOOL)isEmpty {
    return [_heap isEmpty];
}
- (void)clear {
    [_heap clear];
}
- (void)enQueue:(id)element {
    [_heap add:element];
}
- (id)deQueue {
    return [_heap remove];
}
- (id)front {
    return [_heap get];
}
@end
