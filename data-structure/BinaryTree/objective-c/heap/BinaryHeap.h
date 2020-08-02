//
//  BinaryHeap.h
//  BinaryTree
//
//  Created by Ankui on 8/2/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BinaryHeapComparator <NSObject>
@required
- (int)compare:(id)e1 with:(id)e2;
@end

@interface BinaryHeap : NSObject
+ (instancetype)heap;
+ (instancetype)heapWithComparator:(id<BinaryHeapComparator> _Nullable)comparator;
+ (instancetype)heapWithBlock:(NSInteger(^)(id _Nullable, id _Nullable))block;
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)clear;
- (void)add:(id)element;
- (id)get;
- (id)remove;
- (id)replace:(id)element;
- (void)print;
@end

NS_ASSUME_NONNULL_END
