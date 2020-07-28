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
        if ([self _isBalanced:node]) {
            // update height
            [self _updateHeight:node];
        } else {
            // restore balance
            [self _restoreBalance:node];
            break; // CARE!!!
        }
    }
}
- (BOOL)_isBalanced:(TreeNode *)node {
    return labs([((AVLNode *)node) balanceFactor]) <= 1;
}
- (void)_updateHeight:(TreeNode *)node {
    [((AVLNode *)node) updateHeight];
}
- (void)_restoreBalance2:(TreeNode *)grand {
    AVLNode *parent = (AVLNode *)[((AVLNode *)grand) tallerChild];
    AVLNode *node = (AVLNode *)[parent tallerChild];
    if ([parent isLeftChild]) { // L
        if ([node isLeftChild]) { // LL
            [self rotateRight:grand];
        } else { // LR
            [self rotateLeft:parent];
            [self rotateRight:grand];
        }
    } else { // R
        if ([node isLeftChild]) { // RL
            [self rotateRight:parent];
            [self rotateLeft:grand];
        } else { // RR
            [self rotateLeft:grand];
        }
    }
}
- (void)afterRotate:(TreeNode *)grand parent:(TreeNode *)parent child:(TreeNode *)child {
    [super afterRotate:grand parent:parent child:child];
    
    // update height
    [self _updateHeight:grand];
    [self _updateHeight:parent];
}
- (void)_restoreBalance:(TreeNode *)grand {
    AVLNode *parent = (AVLNode *)[((AVLNode *)grand) tallerChild];
    AVLNode *node = (AVLNode *)[parent tallerChild];
    if ([parent isLeftChild]) { // L
        if ([node isLeftChild]) { // LL
            [self rotate:grand
                       b:node c:node->_right
                       d:parent
                       e:parent->_right f:grand];
        } else { // LR
            [self rotate:grand
                       b:parent c:node->_left
                       d:node
                       e:node->_right f:grand];
        }
    } else { // R
        if ([node isLeftChild]) { // RL
            [self rotate:grand
                       b:grand c:node->_left
                       d:node
                       e:node->_right f:parent];
        } else { // RR
            [self rotate:grand
                       b:grand c:parent->_left
                       d:parent
                       e:node->_left f:node];
        }
    }
}
- (void)rotate:(TreeNode *)r b:(TreeNode *)b c:(TreeNode *)c d:(TreeNode *)d e:(TreeNode *)e f:(TreeNode *)f {
    [super rotate:r b:b c:c d:d e:e f:f];
    
    [self _updateHeight:b];
    [self _updateHeight:f];
    [self _updateHeight:d];
}
- (void)afterRemove:(TreeNode *)node {
    while ((node = node->_parent) != nil) {
        if ([self _isBalanced:node]) {
            // update height
            [self _updateHeight:node];
        } else {
            // restore balance
            [self _restoreBalance:node];
        }
    }
}
@end
