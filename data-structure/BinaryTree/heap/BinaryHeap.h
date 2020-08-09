//
//  BinaryHeap.h
//  BinaryTree
//
//  Created by Ankui on 8/2/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Heap.h"

NS_ASSUME_NONNULL_BEGIN

@interface BinaryHeap : Heap
+ (instancetype)heapWithArray:(NSArray *)array;
+ (instancetype)heapWithArray:(NSArray *)array comparator:(id<HeapComparator> _Nullable)comparator;
+ (instancetype)heapWithArray:(NSArray *)array block:(NSInteger(^)(id _Nullable, id _Nullable))block;
- (void)clear;
- (void)add:(id)element;
- (id)get;
- (id)remove;
- (id)replace:(id)element;
- (void)print;
@end

NS_ASSUME_NONNULL_END
