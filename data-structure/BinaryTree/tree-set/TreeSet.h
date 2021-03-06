//
//  TreeSet.h
//  BinaryTree
//
//  Created by Ankui on 7/29/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "RBTree.h"

NS_ASSUME_NONNULL_BEGIN

@interface TreeSet : NSObject
+ (instancetype)set;
//+ (instancetype)setWithComparator:(id<BSTComparator> _Nullable)comparator;
//+ (instancetype)setWithBlock:(int(^_Nullable)(id, id))block;
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)clear;
- (BOOL)contains:(id)element;
- (void)add:(id)element;
- (void)remove:(id)element;
- (void)traversal:(struct Visitor *)visitor;
@end

NS_ASSUME_NONNULL_END
