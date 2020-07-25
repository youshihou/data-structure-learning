//
//  BinarySearchTree.h
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BinaryTree.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BSTComparator <NSObject>
@required
- (int)compare:(id)e1 with:(id)e2;
@end

@interface BinarySearchTree : BinaryTree
+ (instancetype)treeWithComparator:(_Nullable id<BSTComparator>)comparator;
+ (instancetype)treeWithBlock:(int(^_Nullable)(id, id))block;
- (BOOL)contains:(id)element;
- (void)add:(id)element;
- (void)remove:(id)element;
@end

NS_ASSUME_NONNULL_END
