//
//  AVLTree.m
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "AVLTree.h"

@interface AVLNode : TreeNode {
    @protected
    NSUInteger _height;
}
- (NSInteger)balanceFactor;
- (void)updateHeight;
- (TreeNode *)tallerChild;
@end
@implementation AVLNode
- (instancetype)init {
    self = [super init];
    if (self) {
        _height = 1;
    }
    return self;
}
- (NSString *)description {
    return [[NSString alloc] initWithFormat:@"%@_p(%@)_h(%zd)", _element, _parent ? _parent->_element : @"null", _height];
}
- (NSInteger)balanceFactor {
    NSInteger leftHeight = _left ? ((AVLNode *)_left)->_height : 0;
    NSInteger rightHeight = _right ? ((AVLNode *)_right)->_height : 0;
    return leftHeight - rightHeight;
}
- (void)updateHeight {
    NSInteger leftHeight = _left ? ((AVLNode *)_left)->_height : 0;
    NSInteger rightHeight = _right ? ((AVLNode *)_right)->_height : 0;
    _height = 1 + MAX(leftHeight, rightHeight);
}
- (TreeNode *)tallerChild {
    NSInteger leftHeight = _left ? ((AVLNode *)_left)->_height : 0;
    NSInteger rightHeight = _right ? ((AVLNode *)_right)->_height : 0;
    if (leftHeight > rightHeight) { return _left; }
    if (leftHeight < rightHeight) { return _right; }
    return [self isLeftChild] ? _left : _right;
}
@end


@implementation AVLTree
- (TreeNode *)createNodeWith:(id)element parent:(TreeNode *)parent {
    return [AVLNode nodeWith:element parent:parent];
}
- (void)afterAdd:(TreeNode *)node {
    while ((node = node->_parent) != nil) {
        if ([self _isBlanceed:node]) {
            // update height
            [self _updateHeight:node];
        } else {
            // restore balance
            [self _restoreBalance:node];
            break; // CARE!!!
        }
    }
}
- (BOOL)_isBlanceed:(TreeNode *)node {
    return labs([((AVLNode *)node) balanceFactor]) <= 1;
}
- (void)_updateHeight:(TreeNode *)node {
    [((AVLNode *)node) updateHeight];
}
- (void)_restoreBalance:(TreeNode *)grand {
    AVLNode *parent = (AVLNode *)[((AVLNode *)grand) tallerChild];
    AVLNode *node = (AVLNode *)[parent tallerChild];
    if ([parent isLeftChild]) { // L
        if ([node isLeftChild]) { // LL
            [self _rotateRight:grand];
        } else { // LR
            [self _rotateLeft:parent];
            [self _rotateRight:grand];
        }
    } else { // R
        if ([node isLeftChild]) { // RL
            [self _rotateRight:parent];
            [self _rotateLeft:grand];
        } else { // RR
            [self _rotateLeft:grand];
        }
    }
}
- (void)_rotateLeft:(TreeNode *)grand {
    TreeNode *parent = grand->_right;
    TreeNode *child = parent->_left;
    grand->_right = child;
    parent->_left = grand;
    
    [self _afterRotate:grand parent:parent child:child];
}
- (void)_rotateRight:(TreeNode *)grand {
    TreeNode *parent = grand->_left;
    TreeNode *child = parent->_right;
    grand->_left = child;
    parent->_right = grand;
    
    [self _afterRotate:grand parent:parent child:child];
}
- (void)_afterRotate:(TreeNode *)grand parent:(TreeNode *)parent child:(TreeNode *)child {
    // update parent's parent, become the subtree's root
    parent->_parent = grand->_parent;
    if ([grand isLeftChild]) {
        grand->_parent->_left = parent;
    } else if ([grand isRightChild]) {
        grand->_parent->_right = parent;
    } else {
        // grand is root
        _root = parent;
    }
    
    // update child's parent
    if (child) {
        child->_parent = grand;
    }
    
    // update grand's parent
    grand->_parent = parent;
    
    // update height
    [self _updateHeight:grand];
    [self _updateHeight:parent];
}
@end
