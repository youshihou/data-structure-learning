//
//  MinHeap.h
//  Graph
//
//  Created by Ankui on 9/3/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MinHeapComparator <NSObject>
@required
- (int)compare:(id)e1 with:(id)e2;
@end

@interface MinHeap : NSObject
+ (instancetype)heap;
+ (instancetype)heapWithComparator:(id<MinHeapComparator> _Nullable)comparator;
+ (instancetype)heapWithBlock:(NSInteger(^)(id _Nullable, id _Nullable))block;
+ (instancetype)heapWithArray:(NSArray * _Nullable)array;
+ (instancetype)heapWithArray:(NSArray * _Nullable)array comparator:(id<MinHeapComparator> _Nullable)comparator;
+ (instancetype)heapWithArray:(NSArray * _Nullable)array block:(NSInteger(^)(id _Nullable, id _Nullable))block;
+ (instancetype)heapWithSet:(NSSet * _Nullable)set;
+ (instancetype)heapWithSet:(NSSet * _Nullable)set comparator:(id<MinHeapComparator> _Nullable)comparator;
+ (instancetype)heapWithSet:(NSSet * _Nullable)set block:(NSInteger(^)(id _Nullable, id _Nullable))block;

- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)clear;
- (void)addAllArray:(NSArray *)array;
- (void)addAllSet:(NSSet *)set;
- (void)add:(id)element;
- (id)get;
- (id)remove;
- (id)replace:(id)element;

@end

NS_ASSUME_NONNULL_END
