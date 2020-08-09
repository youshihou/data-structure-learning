//
//  Heap.h
//  BinaryTree
//
//  Created by Ankui on 8/3/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HeapComparator <NSObject>
@required
- (int)compare:(id)e1 with:(id)e2;
@end


@interface Heap : NSObject {
    @protected
    NSUInteger _size;
}
+ (instancetype)heap;
+ (instancetype)heapWithComparator:(id<HeapComparator> _Nullable)comparator;
+ (instancetype)heapWithBlock:(NSInteger(^)(id _Nullable, id _Nullable))block;
- (NSUInteger)size;
- (BOOL)isEmpty;
- (NSInteger)compare:(id)e1 e2:(id)e2;
@end

NS_ASSUME_NONNULL_END
