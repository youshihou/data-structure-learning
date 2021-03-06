//
//  BST.m
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BST.h"

@interface BST () {
    int(^_block)(id, id);
    id<BSTComparator> _comparator;
}
@end
@implementation BST
+ (instancetype)treeWithComparator:(id<BSTComparator>)comparator {
    BST *bst = [[self alloc] init];
    bst->_comparator = comparator;
    return bst;
}
+ (instancetype)treeWithBlock:(int (^)(id _Nonnull, id _Nonnull))block {
    BST *bst = [[self alloc] init];
    bst->_block = block;
    return bst;
}

- (BOOL)contains:(id)element {
    return [self _findNode:element] != nil;
}
- (void)add:(id)element {
    if (!element) {
        assert("element must not be nil");
        return;
    }
    if (!_root) {
//        _root = [TreeNode nodeWith:element parent:nil];
        _root = [self createNodeWith:element parent:nil];
        _size++;
        [self afterAdd:_root];
        return;
    }
    
    TreeNode *parent = _root;
    TreeNode *node = _root;
    int cmp = 0;
    while (node) {
        parent = node;
        cmp = [self _compare:element e2:node->_element];
        if (cmp > 0) {
            node = node->_right;
        } else if (cmp < 0) {
            node = node->_left;
        } else {
            node->_element = element;
            return;
        }
    }
//    TreeNode *add = [TreeNode nodeWith:element parent:parent];
    TreeNode* add = [self createNodeWith:element parent:parent];
    if (cmp > 0) {
        parent->_right = add;
    } else {
        parent->_left = add;
    }
    _size++;
    [self afterAdd:add];
}
- (void)remove:(id)element {
    [self _remove:[self _findNode:element]];
}
- (void)_remove:(TreeNode *)node {
    if (!node) { return; }
    _size--;
    if (node->_left && node->_right) {
        TreeNode *s = [self successor:node];
        node->_element = s->_element;
        node = s;
    }
    
    TreeNode *replace = node->_left ?: node->_right;
    if (replace) {
        replace->_parent = node->_parent;
        if (!node->_parent) {
            _root = replace;
        } else if (node == node->_parent->_left) {
            node->_parent->_left = replace;
        } else {
            node->_parent->_right = replace;
        }
//        [self afterRemove:node];
        [self afterRemove:replace];
    }
    else if (!node->_parent) {
        _root = nil;
        [self afterRemove:node];
    }
    else {
        if (node == node->_parent->_left) {
            node->_parent->_left = nil;
        } else {
            node->_parent->_right = nil;
        }
        [self afterRemove:node];
    }
}
- (TreeNode *)_findNode:(id)element {
    TreeNode *node = _root;
    while (node) {
        int cmp = [self _compare:element e2:node->_element];
        if (cmp == 0) { return node; }
        if (cmp > 0) {
            node = node->_right;
        } else {
            node = node->_left;
        }
    }
    return nil;
}
- (void)afterAdd:(TreeNode *)node {}
- (void)afterRemove:(TreeNode *)mode {}
- (TreeNode *)createNodeWith:(id)element parent:(TreeNode * _Nullable)parent {
    return [TreeNode nodeWith:element parent:parent];
}
- (int)_compare:(id)e1 e2:(id)e2 {
    return _block ? _block(e1, e2) : (_comparator ? [_comparator compare:e1 with:e2] : (int)[e1 compare:e2]);
}


// MARK: - BinaryTreeProtocol
- (id)root {
    return _root;
}
- (id)left:(id)object {
    TreeNode *node = object;
    return node ? node->_left : nil;
}
- (id)right:(id)object {
    TreeNode *node = object;
    return node ? node->_right : nil;
}
- (id)string:(id)object {
    return object;
}
@end
