//
//  BBST.m
//  BinaryTree
//
//  Created by Ankui on 7/27/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BBST.h"

@implementation BBST
- (void)rotateLeft:(TreeNode *)grand {
    TreeNode *parent = grand->_right;
    TreeNode *child = parent->_left;
    grand->_right = child;
    parent->_left = grand;
    
    [self afterRotate:grand parent:parent child:child];
}
- (void)rotateRight:(TreeNode *)grand {
    TreeNode *parent = grand->_left;
    TreeNode *child = parent->_right;
    grand->_left = child;
    parent->_right = grand;
    
    [self afterRotate:grand parent:parent child:child];
}
- (void)afterRotate:(TreeNode *)grand parent:(TreeNode *)parent child:(TreeNode *)child {
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
    
//    // update height
//    [self _updateHeight:grand];
//    [self _updateHeight:parent];
}
- (void)rotate:(TreeNode *)r // root
              b:(TreeNode *)b c:(TreeNode *)c
              d:(TreeNode *)d
              e:(TreeNode *)e f:(TreeNode *)f
{
    // update d become the subtree's root
    d->_parent = r->_parent;
    if ([r isLeftChild]) {
        r->_parent->_left = d;
    } else if ([r isRightChild]) {
        r->_parent->_right = d;
    } else {
        _root = d;
    }
    
    // update b-c
    b->_right = c;
    if (c) {
        c->_parent = b;
    }
//    [self _updateHeight:b];
    
    // update e-f
    f->_left = e;
    if (e) {
        e->_parent = f;
    }
//    [self _updateHeight:f];
    
    // update b-d-f
    d->_left = b;
    b->_parent = d;
    d->_right = f;
    f->_parent = d;
//    [self _updateHeight:d];
    
//    [self _updateHeight:b];
//    [self _updateHeight:f];
//    [self _updateHeight:d];
}
@end
