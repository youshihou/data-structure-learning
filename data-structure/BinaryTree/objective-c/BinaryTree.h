//
//  BinaryTree.h
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BinaryTreeProtocol.h"

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
+ (instancetype)nodeWith:(id)element parent:(nullable TreeNode *)parent;
- (BOOL)isLeaf;
- (BOOL)hasTwoChild;
@end


@interface BinaryTree : NSObject <BinaryTreeProtocol> {
//    @protected
    NSUInteger _size;
    TreeNode *_root;
}
+ (instancetype)tree;
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)clear;

- (void)preorder:(struct Visitor *)visitor;
- (void)inorder:(struct Visitor *)visitor;
- (void)postorder:(struct Visitor *)visitor;
- (void)levelOrder:(struct Visitor *)visitor;
- (BOOL)isComplete;
- (NSUInteger)height;
- (NSUInteger)height2;
- (TreeNode *)predcessor:(TreeNode *)node;
- (TreeNode *)successor:(TreeNode *)node;

@end

NS_ASSUME_NONNULL_END
