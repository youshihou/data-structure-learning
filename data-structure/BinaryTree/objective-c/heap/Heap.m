//
//  Heap.m
//  BinaryTree
//
//  Created by Ankui on 8/3/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Heap.h"

@interface Heap () {
    NSInteger(^_block)(id, id);
    id<HeapComparator> _comparator;
}
@end

@implementation Heap
+ (instancetype)heap {
    return [[self alloc] init];
}
+ (instancetype)heapWithComparator:(id<HeapComparator>)comparator {
    Heap *heap = [Heap heap];
    heap->_comparator = comparator;
    return heap;
}
+ (instancetype)heapWithBlock:(NSInteger (^)(id _Nullable, id _Nullable))block {
    Heap *heap = [Heap heap];
    heap->_block = block;
    return heap;
}

- (NSUInteger)size {
    return _size;
}
- (BOOL)isEmpty {
    return _size == 0;
}

- (NSInteger)compare:(id)e1 e2:(id)e2 {
    return _block ? _block(e1, e2) : (_comparator ? [_comparator compare:e1 with:e2] : (NSInteger)[e1 compare:e2]);
}
@end
