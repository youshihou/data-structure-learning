//
//  BinaryTree.h
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct Visitor {
    bool stop;
    bool (*visit)(void *);
};


@interface TreeNode : NSObject {
    @public
    id _element;
    TreeNode *_left;
    TreeNode *_right;
    __weak TreeNode *_parent;
}
+ (instancetype)nodeWith:(id)element parent:(TreeNode * _Nullable)parent;
- (BOOL)isLeaf;
- (BOOL)hasTwoChild;
- (BOOL)isLeftChild;
- (BOOL)isRightChild;
- (TreeNode *)sibling;
@end


@interface BinaryTree : NSObject {
    @protected
    NSUInteger _size;
    TreeNode *_root;
}
+ (instancetype)tree;
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)clear;

- (BOOL)isComplete;
- (NSUInteger)height;
- (NSUInteger)height2;
- (TreeNode *)predcessor:(TreeNode *)node;
- (TreeNode *)successor:(TreeNode *)node;
- (void)preorder:(struct Visitor *)visitor;
- (void)inorder:(struct Visitor *)visitor;
- (void)postorder:(struct Visitor *)visitor;
- (void)levelOrder:(struct Visitor *)visitor;

- (void)preorder_new:(struct Visitor *)visitor;
- (void)inorder_new:(struct Visitor *)visitor;
- (void)postorder_new:(struct Visitor *)visitor;


- (void)inorder_morris:(struct Visitor *)visitor;

@end

NS_ASSUME_NONNULL_END
