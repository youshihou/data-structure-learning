//
//  RBTree.m
//  BinaryTree
//
//  Created by Ankui on 7/25/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "RBTree.h"

@interface RBNode : TreeNode {
    @public
    BOOL _color;
}

@end
@implementation RBNode


@end

@implementation RBTree

static const BOOL RED = NO;
static const BOOL BLACK = YES;

- (TreeNode *)createNodeWith:(id)element parent:(TreeNode *)parent {
    return [RBNode nodeWith:element parent:parent];
}
- (void)afterAdd:(TreeNode *)node {
    
}
- (void)afterRemove:(TreeNode *)node {
    
}
- (TreeNode *)_color:(TreeNode *)node color:(BOOL)color {
    if (!node) { return node; }
    ((RBNode *)node)->_color = color;
    return node;
}
- (TreeNode *)_red:(TreeNode *)node {
    return [self _color:node color:RED];
}
- (TreeNode *)_black:(TreeNode *)node {
    return [self _color:node color:BLACK];
}
- (BOOL)_colorOf:(TreeNode *)node {
    return node ? ((RBNode *)node)->_color : BLACK;
}
- (BOOL)_isRed:(TreeNode *)node {
    return [self _colorOf:node] == RED;
}
- (BOOL)_isBlack:(TreeNode *)node {
    return [self _colorOf:node] == BLACK;
}
@end
