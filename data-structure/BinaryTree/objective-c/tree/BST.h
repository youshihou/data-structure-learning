//
//  BST.h
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BinaryTree.h"
#import "BinaryTreeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BSTComparator <NSObject>
@required
- (int)compare:(id)e1 with:(id)e2;
@end

@interface BST : BinaryTree <BinaryTreeProtocol>
+ (instancetype)treeWithComparator:(id<BSTComparator> _Nullable)comparator;
+ (instancetype)treeWithBlock:(int(^_Nullable)(id, id))block;
- (BOOL)contains:(id)element;
- (void)add:(id)element;
- (void)remove:(id)element;
- (void)afterAdd:(TreeNode *)node;
- (void)afterRemove:(TreeNode *)mode;
- (TreeNode *)createNodeWith:(id)element parent:(TreeNode * _Nullable)parent;
@end

NS_ASSUME_NONNULL_END
