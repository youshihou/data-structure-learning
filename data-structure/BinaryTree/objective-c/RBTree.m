//
//  RBTree.m
//  BinaryTree
//
//  Created by Ankui on 7/25/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "RBTree.h"

static const BOOL RED = NO;
static const BOOL BLACK = YES;

@interface RBTNode : TreeNode {
    @public
    BOOL _color;
}
@end
@implementation RBTNode
- (instancetype)init {
    self = [super init];
    if (self) {
        _color = RED;
    }
    return self;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"%@%@", _color == RED ? @"R_" : @"", _element];
}
@end


@implementation RBTree
- (TreeNode *)createNodeWith:(id)element parent:(TreeNode *)parent {
    return [RBTNode nodeWith:element parent:parent];
}
- (void)afterAdd:(TreeNode *)node {
    TreeNode *parent = node->_parent;
    
    // root
    if (!parent) {
        [self _black:node];
        return;
    }
    
    // parent is black
    if ([self _isBlack:parent]) { return; }
    
    TreeNode *uncle = [parent sibling];
    TreeNode *grand = parent->_parent;
    // uncle is red, overflow
    if ([self _isRed:uncle]) {
        [self _black:parent];
        [self _black:uncle];
        // will grand as new add node
        [self afterAdd:[self _red:grand]];
        return;
    }
    
    // uncel is not red, underflow
    if ([parent isLeftChild]) { // L
        [self _red:grand];
        if ([node isLeftChild]) { // LL
            [self _black:parent];
        } else { // LR
            [self _black:node];
            [self rotateLeft:parent];
        }
        [self rotateRight:grand];
    } else { // R
        [self _red:grand];
        if ([node isLeftChild]) { // RL
            [self _black:node];
            [self rotateRight:parent];
        } else { // RR
            [self _black:parent];
        }
        [self rotateLeft:grand];
    }
}
- (void)afterRemove:(TreeNode *)node {
    
}
- (TreeNode *)_color:(TreeNode *)node color:(BOOL)color {
    if (!node) { return node; }
    ((RBTNode *)node)->_color = color;
    return node;
}
- (TreeNode *)_red:(TreeNode *)node {
    return [self _color:node color:RED];
}
- (TreeNode *)_black:(TreeNode *)node {
    return [self _color:node color:BLACK];
}
- (BOOL)_colorOf:(TreeNode *)node {
    return node ? ((RBTNode *)node)->_color : BLACK;
}
- (BOOL)_isRed:(TreeNode *)node {
    return [self _colorOf:node] == RED;
}
- (BOOL)_isBlack:(TreeNode *)node {
    return [self _colorOf:node] == BLACK;
}
@end
