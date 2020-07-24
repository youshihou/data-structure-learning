//
//  BinarySearchTree.m
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BinarySearchTree.h"

@interface BSTNode : NSObject {
    @public
    id _element;
    BSTNode *_left;
    BSTNode *_right;
    __weak BSTNode *_parent;
}
@end
@implementation BSTNode
+ (instancetype)nodeWith:(id)element parent:(BSTNode *)parent {
    BSTNode *n = [[self alloc] init];
    n->_element = element;
    n->_parent = parent;
    return n;
}
@end

@interface BinarySearchTree () {
    NSUInteger _size;
    BSTNode *_root;
    int(^_block)(id, id);
    id<BSTComparator> _comparator;
}
@end
@implementation BinarySearchTree
+ (instancetype)tree {
    return [self treeWithComparator:nil];
}
+ (instancetype)treeWithComparator:(id<BSTComparator>)comparator {
    BinarySearchTree *bst = [[self alloc] init];
    bst->_comparator = comparator;
    return bst;
}
+ (instancetype)treeWithBlock:(int (^)(id, id))block {
    BinarySearchTree *bst = [[self alloc] init];
    bst->_block = block;
    return bst;
}

- (NSUInteger)size {
    return _size;
}
- (BOOL)isEmpty {
    return _size == 0;
}
- (void)add:(id)element {
    if (!element) { return; }
    if (!_root) {
        _root = [BSTNode nodeWith:element parent:nil];
        _size++;
        return;
    }
    
    BSTNode *parent = _root;
    BSTNode *node = _root;
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
    BSTNode *add = [BSTNode nodeWith:element parent:parent];
    if (cmp > 0) {
        parent->_right = add;
    } else {
        parent->_left = add;
    }
    _size++;
}
- (void)remove:(id)element {
    [self _remove:[self _findNode:element]];
}
- (void)_remove:(BSTNode *)node {
    if (!node) { return; }
    _size--;
    if (node->_left && node->_right) {
        BSTNode *s = [self _successor:node];
        node->_element = s->_element;
        node = s;
    }
    
    BSTNode *replace = node->_left ?: node->_right;
    if (replace) {
        replace->_parent = node->_parent;
        if (!node->_parent) {
            _root = replace;
        } else if (node == node->_parent->_left) {
            node->_parent->_left = replace;
        } else {
            node->_parent->_right = replace;
        }
    }
    else if (!node->_parent) {
        _root = nil;
    }
    else {
        if (node == node->_parent->_left) {
            node->_parent->_left = nil;
        } else {
            node->_parent->_right = nil;
        }
    }
}
- (BSTNode *)_findNode:(id)element {
    BSTNode *node = _root;
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
- (BSTNode *)_predecessor:(BSTNode *)node {
    if (!node) { return nil; }
    BSTNode *p = _root->_left;
    if (p) {
        while (p->_right) {
            p = p->_right;
        }
        return p;
    }
    
    while (node->_parent && node == node->_parent->_left) {
        node = node->_parent;
    }
    return node->_parent;
}
- (BSTNode *)_successor:(BSTNode *)node {
    if (!node) { return nil; }
    BSTNode *s = node->_right;
    if (s) {
        while (s->_left) {
            s = s->_left;
        }
        return s;
    }
    
    while (node->_parent && node == node->_parent->_right) {
        node = node->_parent;
    }
    return node->_parent;
}

- (int)_compare:(id)e1 e2:(id)e2 {
    return _block ? _block(e1, e2) : (_comparator ? [_comparator compare:e1 with:e2] : (int)[e1 compare:e2]);
}

- (id)root {
    return _root;
}
- (id)left:(id)object {
    BSTNode *node = object;
    return node->_left;
}
- (id)right:(id)object {
    BSTNode *node = object;
    return node->_right;
}
- (id)string:(id)object {
    BSTNode *node = object;
//    return node->_element;
    return [NSString stringWithFormat:@"%@_p(%@)", node->_element, node->_parent ? node->_parent->_element : @"null"];
}
@end
